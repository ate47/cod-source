#using script_4dac3680f88a01c3;
#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\endmission;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\interaction_manager;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\outline;
#using scripts\sp\player;
#using scripts\sp\player\gestures;
#using scripts\sp\player\playerchatter;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\trigger;
#using scripts\sp\utility;

#namespace utility;

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x3256
// Size: 0xc9
function function_df57c8a03e293db4( anime )
{
    assertex( isdefined( level.scr_anim ), "No level.scr_ animation arrays exist!" );
    animnames = [];
    
    foreach ( array in level.scr_anim )
    {
        foreach ( xanim in array )
        {
            if ( scene == anime )
            {
                animnames[ animnames.size ] = animname;
            }
        }
    }
    
    return animnames;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x3328
// Size: 0x4d
function get_tag_list( model )
{
    array = [];
    numparts = getnumparts( model );
    
    for ( i = 0; i < numparts ; i++ )
    {
        array[ array.size ] = getpartname( model, i );
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x337e
// Size: 0xce
function get_all_closest_living( org, ai_array, max_dist, bincludelongdeath )
{
    temp_array = [];
    
    if ( ai_array.size < 1 )
    {
        return temp_array;
    }
    
    if ( !isdefined( bincludelongdeath ) )
    {
        bincludelongdeath = 0;
    }
    
    max_dist = squared( max_dist );
    
    foreach ( guy in ai_array )
    {
        if ( !isalive( guy ) || !isdefined( guy ) || !bincludelongdeath && guy scripts\engine\utility::doinglongdeath() )
        {
            continue;
        }
        
        if ( distancesquared( guy.origin, org ) <= max_dist )
        {
            temp_array[ temp_array.size ] = guy;
        }
    }
    
    return temp_array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3455
// Size: 0xa7
function set_hudoutline( stype, depth_enable, fill_enable )
{
    num = undefined;
    assertex( isdefined( stype ) && isstring( stype ), "set_HudOutline() needs a string! Use 'friendly', 'enemy', 'objective', or 'neutral' " );
    stype = tolower( stype );
    array[ "friendly" ] = "outline_nodepth_cyan";
    array[ "enemy" ] = "outline_nodepth_red";
    array[ "objective" ] = "outline_nodepth_orange";
    array[ "neutral" ] = "outline_nodepth_white";
    assertex( isdefined( array[ stype ] ), "set_hudOutline() called with invalid type. Use 'friendly', 'enemy', 'objective', or 'neutral' " );
    num = array[ stype ];
    hudoutline_enable_new( array[ stype ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3504
// Size: 0xfa
function convert_to_time_string( timer, var_9930ab910b718a51 )
{
    string = "";
    
    if ( timer < 0 )
    {
        string += "-";
    }
    
    timer = math::round_float( timer, 1, 0 );
    var_87272c6f95dd558e = timer * 100;
    var_87272c6f95dd558e = int( var_87272c6f95dd558e );
    var_87272c6f95dd558e = abs( var_87272c6f95dd558e );
    minutes = var_87272c6f95dd558e / 6000;
    minutes = int( minutes );
    string += minutes;
    seconds = var_87272c6f95dd558e / 100;
    seconds = int( seconds );
    seconds -= minutes * 60;
    
    if ( seconds < 10 )
    {
        string += ":0" + seconds;
    }
    else
    {
        string += ":" + seconds;
    }
    
    if ( isdefined( var_9930ab910b718a51 ) && var_9930ab910b718a51 )
    {
        tenths = var_87272c6f95dd558e;
        tenths -= minutes * 6000;
        tenths -= seconds * 100;
        tenths = int( tenths / 10 );
        string += "." + tenths;
    }
    
    return string;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3607
// Size: 0xc9
function sun_light_fade( startsunlight, endsunlight, ftime )
{
    ftime = int( ftime * 20 );
    increment = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        increment[ i ] = ( startsunlight[ i ] - endsunlight[ i ] ) / ftime;
    }
    
    newsunlight = [];
    
    for ( i = 0; i < ftime ; i++ )
    {
        wait 0.05;
        
        for ( j = 0; j < 4 ; j++ )
        {
            newsunlight[ j ] = startsunlight[ j ] - increment[ j ] * i;
        }
        
        setsuncolorandintensity( newsunlight[ 0 ], newsunlight[ 1 ], newsunlight[ 2 ], newsunlight[ 3 ] );
    }
    
    setsuncolorandintensity( endsunlight[ 0 ], endsunlight[ 1 ], endsunlight[ 2 ], endsunlight[ 3 ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x36d8
// Size: 0x14d
function get_closest_to_player_view( array, player, use_eye, min_dot )
{
    if ( !array.size )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        player = level.player;
    }
    
    if ( !isdefined( min_dot ) )
    {
        min_dot = -1;
    }
    
    player_origin = player.origin;
    
    if ( isdefined( use_eye ) && use_eye )
    {
        player_origin = player geteye();
    }
    
    ent = undefined;
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    dot = -1;
    
    foreach ( array_item in array )
    {
        angles = vectortoangles( array_item.origin - player_origin );
        forward = anglestoforward( angles );
        newdot = vectordot( player_forward, forward );
        
        if ( newdot < dot )
        {
            continue;
        }
        
        if ( newdot < min_dot )
        {
            continue;
        }
        
        dot = newdot;
        ent = array_item;
    }
    
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x382e
// Size: 0x109
function get_closest_index_to_player_view( array, player, use_eye )
{
    if ( !array.size )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        player = level.player;
    }
    
    player_origin = player.origin;
    
    if ( isdefined( use_eye ) && use_eye )
    {
        player_origin = player geteye();
    }
    
    index = undefined;
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    dot = -1;
    
    for ( i = 0; i < array.size ; i++ )
    {
        angles = vectortoangles( array[ i ].origin - player_origin );
        forward = anglestoforward( angles );
        newdot = vectordot( player_forward, forward );
        
        if ( newdot < dot )
        {
            continue;
        }
        
        dot = newdot;
        index = i;
    }
    
    return index;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3940
// Size: 0x55
function flag_trigger_init( message, trigger, continuous )
{
    flag_init( message );
    
    if ( !isdefined( continuous ) )
    {
        continuous = 0;
    }
    
    assert( issubstr( trigger.classname, "trigger" ) );
    trigger thread _flag_wait_trigger( message, continuous );
    return trigger;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x399e
// Size: 0x72
function flag_triggers_init( message, triggers, all )
{
    flag_init( message );
    
    if ( !isdefined( all ) )
    {
        all = 0;
    }
    
    for ( index = 0; index < triggers.size ; index++ )
    {
        assert( issubstr( triggers[ index ].classname, "trigger" ) );
        triggers[ index ] thread _flag_wait_trigger( message, 0 );
    }
    
    return triggers;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3a19
// Size: 0x1d
function flag_clear_delayed( message, delay )
{
    wait delay;
    flag_clear( message );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3a3e
// Size: 0x20
function flag_clear_delayed_endonset( message, delay )
{
    level endon( message );
    wait delay;
    flag_clear( message );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x3a66
// Size: 0xb5
function level_end_save()
{
    if ( level.missionfailed )
    {
        return;
    }
    
    if ( scripts\sp\utility::is_trials_level() )
    {
        return 0;
    }
    
    if ( flag( "game_saving" ) )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( !isalive( player ) )
        {
            return;
        }
    }
    
    flag_set( "game_saving" );
    imagename = "levelshots / autosave / autosave_" + level.script + "end";
    savegame( "levelend", &"AUTOSAVE_AUTOSAVE", imagename, 1 );
    flag_clear( "game_saving" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3b23
// Size: 0x6c
function add_extra_autosave_check( name, func, msg )
{
    level.autosave.extra_autosave_checks[ name ] = [];
    level.autosave.extra_autosave_checks[ name ][ "func" ] = func;
    level.autosave.extra_autosave_checks[ name ][ "msg" ] = msg;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x3b97
// Size: 0x20
function remove_extra_autosave_check( name )
{
    level.autosave.extra_autosave_checks[ name ] = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x3bbf
// Size: 0x13
function autosave_silent()
{
    thread autosave_by_name_thread( "autosave_silent", undefined, undefined, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x3bda
// Size: 0x13
function autosave_stealth()
{
    thread autosave_by_name_thread( "autosave_stealth", 8, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x3bf5
// Size: 0x15
function autosave_stealth_silent()
{
    thread autosave_by_name_thread( "autosave_stealth", 8, 1, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x3c12
// Size: 0x11
function autosave_tactical()
{
    autosave_tactical_setup();
    thread autosave_tactical_proc();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x3c2b
// Size: 0x14
function autosave_by_name( name )
{
    thread autosave_by_name_thread( name );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x3c47
// Size: 0x18
function autosave_by_name_silent( name )
{
    thread autosave_by_name_thread( name, undefined, undefined, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x3c67
// Size: 0x70
function autosave_by_name_thread( name, timeout, var_f78389d2b10c1f26, suppress_hint, tryonce )
{
    if ( !isdefined( name ) )
    {
        name = "undefined";
    }
    
    imagename = "levelshots/autosave/autosave_" + level.script;
    result = level scripts\sp\autosave::tryautosave( name, "autosave", imagename, timeout, var_f78389d2b10c1f26, suppress_hint, tryonce );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3cdf
// Size: 0x1d
function autosave_or_timeout( name, timeout )
{
    thread autosave_by_name_thread( name, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3d04
// Size: 0x21
function autosave_try_once( name, suppress_hint )
{
    thread autosave_by_name_thread( name, undefined, undefined, suppress_hint, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3d2d
// Size: 0x20
function autosave_or_timeout_silent( name, timeout )
{
    thread autosave_by_name_thread( name, timeout, undefined, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x3d55
// Size: 0xc0
function debug_message( message, origin, duration, entity )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( isdefined( entity ) )
    {
        entity endon( "death" );
        origin = entity.origin;
    }
    
    for ( time = 0; time < duration * 20 ; time++ )
    {
        if ( !isdefined( entity ) )
        {
            /#
                print3d( origin + ( 0, 0, 45 ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
            #/
        }
        else
        {
            /#
                print3d( entity.origin, message, ( 0.48, 9.4, 0.76 ), 0.85 );
            #/
        }
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x3e1d
// Size: 0x92
function debug_message_clear( message, origin, duration, extraendon )
{
    if ( isdefined( extraendon ) )
    {
        level notify( message + extraendon );
        level endon( message + extraendon );
    }
    else
    {
        level notify( message );
        level endon( message );
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    for ( time = 0; time < duration * 20 ; time++ )
    {
        /#
            print3d( origin + ( 0, 0, 45 ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
        #/
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3eb7
// Size: 0x16, Type: bool
function closerfunc( dist1, dist2 )
{
    return dist1 >= dist2;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3ed6
// Size: 0x29
function getclosestfx( org, fxarray, dist )
{
    return comparesizesfx( org, fxarray, dist, &closerfunc );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x3f08
// Size: 0x87
function get_farthest_ent( org, array )
{
    if ( array.size < 1 )
    {
        return;
    }
    
    dist = distance( array[ 0 ] getorigin(), org );
    ent = array[ 0 ];
    
    for ( i = 0; i < array.size ; i++ )
    {
        newdist = distance( array[ i ] getorigin(), org );
        
        if ( newdist < dist )
        {
            continue;
        }
        
        dist = newdist;
        ent = array[ i ];
    }
    
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x3f98
// Size: 0x61
function get_within_range( org, array, dist )
{
    guys = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( distance( array[ i ].origin, org ) <= dist )
        {
            guys[ guys.size ] = array[ i ];
        }
    }
    
    return guys;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4002
// Size: 0x61
function get_outside_range( org, array, dist )
{
    guys = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( distance( array[ i ].origin, org ) > dist )
        {
            guys[ guys.size ] = array[ i ];
        }
    }
    
    return guys;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x406c
// Size: 0x93
function get_closest_living( org, array, dist )
{
    if ( !isdefined( dist ) )
    {
        dist = 9999999;
    }
    
    if ( array.size < 1 )
    {
        return;
    }
    
    ent = undefined;
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( !isalive( array[ i ] ) )
        {
            continue;
        }
        
        newdist = distance( array[ i ].origin, org );
        
        if ( newdist >= dist )
        {
            continue;
        }
        
        dist = newdist;
        ent = array[ i ];
    }
    
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4108
// Size: 0xef
function get_highest_dot( start, end, array )
{
    if ( !array.size )
    {
        return;
    }
    
    ent = undefined;
    angles = vectortoangles( end - start );
    dotforward = anglestoforward( angles );
    dot = -1;
    
    foreach ( member in array )
    {
        angles = vectortoangles( member.origin - start );
        forward = anglestoforward( angles );
        newdot = vectordot( dotforward, forward );
        
        if ( newdot < dot )
        {
            continue;
        }
        
        dot = newdot;
        ent = member;
    }
    
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4200
// Size: 0xac
function get_closest_index( org, array, dist )
{
    if ( !isdefined( dist ) )
    {
        dist = 9999999;
    }
    
    if ( array.size < 1 )
    {
        return;
    }
    
    index = undefined;
    
    foreach ( ent in array )
    {
        newdist = distance( ent.origin, org );
        
        if ( newdist >= dist )
        {
            continue;
        }
        
        dist = newdist;
        index = i;
    }
    
    return index;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x42b5
// Size: 0x62
function get_closest_exclude( org, ents, excluders )
{
    if ( !isarray( ents ) || ents.size == 0 )
    {
        return undefined;
    }
    
    checkents = array_remove_array( ents, excluders );
    
    if ( checkents.size == 0 )
    {
        return undefined;
    }
    else if ( checkents.size > 1 )
    {
        checkents = sortbydistance( checkents, org );
    }
    
    return checkents[ 0 ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4320
// Size: 0x68
function get_closest_ai( org, team, excluders )
{
    if ( isdefined( team ) )
    {
        ents = getaiarray( team );
    }
    else
    {
        ents = getaiarray();
    }
    
    if ( ents.size == 0 )
    {
        return undefined;
    }
    
    if ( isdefined( excluders ) )
    {
        assert( excluders.size > 0 );
        ents = array_remove_array( ents, excluders );
    }
    
    return getclosest( org, ents );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4391
// Size: 0x4d
function get_closest_ai_exclude( org, team, excluders )
{
    if ( isdefined( team ) )
    {
        ents = getaiarray( team );
    }
    else
    {
        ents = getaiarray();
    }
    
    if ( ents.size == 0 )
    {
        return undefined;
    }
    
    return get_closest_exclude( org, ents, excluders );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x43e7
// Size: 0x85
function get_progress( start, end, org, dist )
{
    if ( !isdefined( dist ) )
    {
        dist = distance( start, end );
    }
    
    dist = max( 0.01, dist );
    normal = vectornormalize( end - start );
    vec = org - start;
    progress = vectordot( vec, normal );
    progress /= dist;
    progress = clamp( progress, 0, 1 );
    return progress;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4475
// Size: 0x14
function enable_blood_pool()
{
    self.skipbloodpool = undefined;
    self setragdollnobloodpoolfx( 0 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4491
// Size: 0x16
function disable_blood_pool()
{
    self.skipbloodpool = 1;
    self setragdollnobloodpoolfx( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x44af
// Size: 0xb
function deletable_magic_bullet_shield()
{
    magic_bullet_shield( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x44c2
// Size: 0xd
function get_ignoreme()
{
    return val::get( "ignoreme" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x44d8
// Size: 0x4b
function set_ignoreme( val )
{
    assertex( issentient( self ), "Non ai tried to set ignoreme" );
    
    if ( istrue( val ) )
    {
        val::set( "sp_utility", "ignoreme", 1 );
        return;
    }
    
    val::reset( "sp_utility", "ignoreme" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x452b
// Size: 0x4b
function set_ignoreall( val )
{
    assertex( issentient( self ), "Non ai tried to set ignoreall" );
    
    if ( istrue( val ) )
    {
        val::set( "sp_utility", "ignoreall", 1 );
        return;
    }
    
    val::reset( "sp_utility", "ignoreall" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x457e
// Size: 0x21
function get_ignoreall()
{
    assertex( issentient( self ), "Non ai tried to get ignoraell" );
    return val::get( "ignoreall" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x45a8
// Size: 0x15
function set_favoriteenemy( enemy )
{
    self.favoriteenemy = enemy;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x45c5
// Size: 0xb
function get_pacifist()
{
    return self.pacifist;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x45d9
// Size: 0x29
function set_pacifist( val )
{
    assertex( issentient( self ), "Non ai tried to set pacifist" );
    self.pacifist = val;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x460a
// Size: 0x15
function set_maxsightdistsquared( value )
{
    self.maxsightdistsqrd = value;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4627
// Size: 0x15
function set_maxvisibledist( value )
{
    self.maxvisibledist = value;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4644
// Size: 0x15
function set_maxfaceenemydist( value )
{
    self.maxfaceenemydist = value;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4661
// Size: 0x15
function set_sprint( value )
{
    self.sprint = value;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x467e
// Size: 0x13
function flood_spawn( spawners )
{
    scripts\sp\spawner::flood_spawner_scripted( spawners );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x4699
// Size: 0x46
function force_crawling_death( angle, num_crawls, array, nofallanim )
{
    assertmsg( "Don't use this, it's deprecated. And we need a better wrapper" );
    
    if ( !isdefined( num_crawls ) )
    {
        num_crawls = 4;
    }
    
    thread force_crawling_death_proc( angle, num_crawls, array, nofallanim );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x46e7
// Size: 0x15e
function override_crawl_death_anims()
{
    if ( isdefined( self.a.custom_crawling_death_array ) )
    {
        self.a.array[ "crawl" ] = self.a.custom_crawling_death_array[ "crawl" ];
        self.a.array[ "death" ] = self.a.custom_crawling_death_array[ "death" ];
        self.a.crawl_fx_rate = self.a.custom_crawling_death_array[ "blood_fx_rate" ];
        
        if ( isdefined( self.a.custom_crawling_death_array[ "blood_fx" ] ) )
        {
            self.a.crawl_fx = self.a.custom_crawling_death_array[ "blood_fx" ];
        }
    }
    
    self.a.array[ "stand_2_crawl" ] = [];
    
    if ( isdefined( self.nofallanim ) )
    {
        self.currentpose = "prone";
    }
    
    self orientmode( "face angle", self.a.force_crawl_angle );
    self.a.force_crawl_angle = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x484d
// Size: 0xdb
function force_crawling_death_proc( angle, num_crawls, array, nofallanim )
{
    self.forcelongdeath = 1;
    self.force_num_crawls = num_crawls;
    self.noragdoll = 1;
    self.nofallanim = nofallanim;
    self.a.custom_crawling_death_array = array;
    self.crawlingpainanimoverridefunc = &override_crawl_death_anims;
    self.maxhealth = 100000;
    self.health = 100000;
    ai::enable_long_death();
    
    if ( !isdefined( nofallanim ) || nofallanim == 0 )
    {
        self.a.force_crawl_angle = angle + 181.02;
        return;
    }
    
    self.a.force_crawl_angle = angle;
    thread scripts\anim\notetracks_sp::notetrackposecrawl();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4930
// Size: 0x14
function ai_ragdoll_immediate()
{
    self.skipdeathanim = 1;
    die();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x494c
// Size: 0xe6
function playerwatch_unresolved_collision( count )
{
    self endon( "death" );
    self endon( "stop_unresolved_collision_script" );
    
    if ( !isdefined( count ) )
    {
        count = 20;
    }
    
    self.unresolved_collision_count = 0;
    
    while ( true )
    {
        self waittill( "unresolved_collision", mover );
        self.last_unresolved_collision_time = gettime();
        
        if ( isdefined( mover ) && ( istrue( mover.doorclip ) || istrue( mover.allowunresolvedcollision ) ) )
        {
            continue;
        }
        
        childthread resetunresolvedcollision();
        self.unresolved_collision_count++;
        
        if ( self.unresolved_collision_count >= count )
        {
            if ( isdefined( mover ) && isdefined( mover.unresolved_collision_func ) )
            {
                mover [[ mover.unresolved_collision_func ]]( self );
            }
            
            if ( isdefined( self.handle_unresolved_collision ) )
            {
                self [[ self.handle_unresolved_collision ]]();
                continue;
            }
            
            default_unresolved_collision_handler();
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4a3a
// Size: 0x22
function resetunresolvedcollision()
{
    self notify( "newUnresolvedCollision" );
    self endon( "newUnresolvedCollision" );
    wait 0.05;
    waittillframeend();
    self.unresolved_collision_count = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4a64
// Size: 0x15
function default_unresolved_collision_handler()
{
    level.custom_death_quote = 438;
    scripts\sp\utility::missionfailedwrapper();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4a81
// Size: 0xa
function stop_playerwatch_unresolved_collision()
{
    self notify( "stop_unresolved_collision_script" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4a93
// Size: 0x1e
function play_sound_on_tag_endon_death( alias, tag )
{
    play_sound_on_tag( alias, tag, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x4ab9
// Size: 0xe0
function play_loop_sound_on_entity_with_pitch( alias, offset, pitch_amount, pitch_time )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( "death" );
    thread delete_on_death( org );
    
    if ( !isdefined( pitch_amount ) )
    {
        pitch_amount = 0;
    }
    
    if ( !isdefined( pitch_time ) )
    {
        pitch_time = 0;
    }
    
    if ( isdefined( offset ) )
    {
        org.origin = self.origin + offset;
    }
    else
    {
        org.origin = self.origin;
    }
    
    org.angles = self.angles;
    org linkto( self );
    org playloopsound( alias );
    org scalepitch( pitch_amount, pitch_time );
    self waittill( "stop sound" + alias );
    org stoploopsound( alias );
    org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4ba1
// Size: 0x33
function play_sound_on_entity( alias, var_b426f32755673ba6 )
{
    assertex( !isspawner( self ), "Spawner tried to play a sound" );
    play_sound_on_tag( alias, undefined, undefined, var_b426f32755673ba6 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4bdc
// Size: 0x60
function assign_animtree( animname )
{
    if ( isdefined( animname ) )
    {
        self.animname = animname;
    }
    
    assertex( isdefined( level.scr_animtree[ self.animname ] ), "There is no level.scr_animtree for animname " + self.animname );
    self useanimtree( level.scr_animtree[ self.animname ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x4c44
// Size: 0xa6
function assign_model()
{
    assertex( isdefined( level.scr_model[ self.animname ] ), "There is no level.scr_model for animname " + self.animname );
    
    if ( isarray( level.scr_model[ self.animname ] ) )
    {
        randindex = randomint( level.scr_model[ self.animname ].size );
        self setmodel( level.scr_model[ self.animname ][ randindex ] );
        return;
    }
    
    self setmodel( level.scr_model[ self.animname ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x4cf2
// Size: 0x75
function spawn_anim_model( animname, origin, angles )
{
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    model = spawn( "script_model", origin );
    model.animname = animname;
    model assign_animtree();
    model assign_model();
    
    if ( isdefined( angles ) )
    {
        model.angles = angles;
    }
    
    return model;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x4d70
// Size: 0xe8
function spawn_anim_weapon( animname, origin, angles, viewmodel )
{
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( viewmodel ) )
    {
        viewmodel = 0;
    }
    
    model = spawn( "script_model", origin );
    model.animname = animname;
    model assign_animtree();
    assertex( isdefined( level.scr_weapon[ animname ] ), "There is no level.scr_weapon for animname " + model.animname );
    attachments = [];
    
    if ( isdefined( level.scr_weapon[ animname ][ 1 ] ) )
    {
        attachments = level.scr_weapon[ animname ][ 1 ];
    }
    
    model make_weapon_model( level.scr_weapon[ animname ][ 0 ], attachments, viewmodel );
    
    if ( isdefined( angles ) )
    {
        model.angles = angles;
    }
    
    return model;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4e61
// Size: 0x5c
function trigger_wait( strname, strkey )
{
    etrigger = getent( strname, strkey );
    
    if ( !isdefined( etrigger ) )
    {
        assertmsg( "trigger not found: " + strname + " key: " + strkey );
        return;
    }
    
    etrigger waittill( "trigger", eother );
    level notify( strname, eother );
    return eother;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4ec6
// Size: 0x17
function trigger_wait_targetname( strname )
{
    return trigger_wait( strname, "targetname" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4ee6
// Size: 0x27
function set_flag_on_dead( spawners, strflag )
{
    thread set_flag_on_func_wait_proc( spawners, strflag, &waittill_dead, "set_flag_on_dead" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4f15
// Size: 0x27
function set_flag_on_dead_or_dying( spawners, strflag )
{
    thread set_flag_on_func_wait_proc( spawners, strflag, &waittill_dead_or_dying, "set_flag_on_dead_or_dying" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x4f44
// Size: 0xb
function empty_func( var )
{
    
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x4f58
// Size: 0x53
function set_flag_on_spawned_ai_proc( system, internal_flag )
{
    self waittill( "spawned", guy );
    
    if ( spawn_failed( guy ) )
    {
        return;
    }
    
    system.ai[ system.ai.size ] = guy;
    ent_flag_set( internal_flag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x4fb3
// Size: 0xfe
function set_flag_on_func_wait_proc( spawners, strflag, waitfunc, internal_flag )
{
    system = spawnstruct();
    system.ai = [];
    assertex( spawners.size, "spawners is empty" );
    
    foreach ( key, spawn in spawners )
    {
        spawn ent_flag_init( internal_flag );
    }
    
    array_thread( spawners, &set_flag_on_spawned_ai_proc, system, internal_flag );
    
    foreach ( spawn in spawners )
    {
        spawn ent_flag_wait( internal_flag );
    }
    
    [[ waitfunc ]]( system.ai );
    flag_set( strflag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x50b9
// Size: 0x3a
function set_flag_on_trigger( etrigger, strflag )
{
    if ( !flag( strflag ) )
    {
        etrigger waittill( "trigger", eother );
        flag_set( strflag );
        return eother;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x50fb
// Size: 0x3c
function set_flag_on_targetname_trigger( msg )
{
    if ( flag( msg ) )
    {
        return;
    }
    
    trigger = getent( msg, "targetname" );
    trigger waittill( "trigger" );
    flag_set( msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x513f
// Size: 0x175
function waittill_dead( guys, num, timeoutlength )
{
    /#
        allalive = 1;
        
        foreach ( member in guys )
        {
            if ( isalive( member ) )
            {
                continue;
            }
            
            allalive = 0;
            break;
        }
        
        assertex( allalive, "<dev string:x1c>" );
        
        if ( !allalive )
        {
            newarray = [];
            
            foreach ( member in guys )
            {
                if ( isalive( member ) )
                {
                    newarray[ newarray.size ] = member;
                }
            }
            
            guys = newarray;
        }
    #/
    
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( "thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( isdefined( num ) && num < ent.count )
    {
        ent.count = num;
    }
    
    array_thread( guys, &waittill_dead_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( "waittill_dead guy died" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x52bc
// Size: 0x10f
function waittill_dead_or_dying( guys, num, timeoutlength )
{
    newarray = [];
    
    foreach ( member in guys )
    {
        if ( isalive( member ) && !member.ignoreforfixednodesafecheck )
        {
            newarray[ newarray.size ] = member;
        }
    }
    
    guys = newarray;
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( "thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( isdefined( num ) && num < ent.count )
    {
        ent.count = num;
    }
    
    array_thread( guys, &waittill_dead_or_dying_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( "waittill_dead_guy_dead_or_dying" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x53d3
// Size: 0x24
function waittill_notetrack_or_damage( notetrack )
{
    self endon( "damage" );
    self endon( "death" );
    self waittillmatch( "single anim", notetrack );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x53ff
// Size: 0x51
function get_living_ai( name, type )
{
    array = get_living_ai_array( name, type );
    
    if ( array.size > 1 )
    {
        assertmsg( "get_living_ai used for more than one living ai of type " + type + " called " + name + "." );
        return undefined;
    }
    
    return array[ 0 ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5459
// Size: 0x132
function get_living_ai_array( name, type )
{
    ai = getaispeciesarray( "all", "all" );
    array = [];
    
    foreach ( actor in ai )
    {
        if ( !isalive( actor ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_5a532485943b3d4b":
                if ( isdefined( actor.targetname ) && actor.targetname == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
            case #"hash_6d8a4db48060bf8":
                if ( isdefined( actor.script_noteworthy ) && actor.script_noteworthy == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
            case #"hash_a9ba80180b5bb733":
                if ( isdefined( actor.animname ) && actor.animname == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5594
// Size: 0x63
function get_vehicle( name, type )
{
    assert( isdefined( name ) );
    assert( isdefined( type ) );
    array = get_vehicle_array( name, type );
    
    if ( !array.size )
    {
        return undefined;
    }
    
    assertex( array.size == 1, "tried to get_vehicle() on vehicles with key-pair: " + name + "," + type );
    return array[ 0 ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5600
// Size: 0xdb
function get_vehicle_array( name, type )
{
    array = getentarray( name, type );
    vehicle = [];
    merge_array = [];
    
    foreach ( object in array )
    {
        if ( object.code_classname != "script_vehicle" )
        {
            continue;
        }
        
        merge_array[ 0 ] = object;
        
        if ( isspawner( object ) )
        {
            if ( isdefined( object.last_spawned_vehicle ) )
            {
                merge_array[ 0 ] = object.last_spawned_vehicle;
                vehicle = array_merge( vehicle, merge_array );
            }
            
            continue;
        }
        
        vehicle = array_merge( vehicle, merge_array );
    }
    
    return vehicle;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x56e4
// Size: 0x5a
function get_living_aispecies( name, type, breed )
{
    array = get_living_aispecies_array( name, type, breed );
    
    if ( array.size > 1 )
    {
        assertmsg( "get_living_aispecies used for more than one living ai of type " + type + " called " + name + "." );
        return undefined;
    }
    
    return array[ 0 ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x5747
// Size: 0xf6
function get_living_aispecies_array( name, type, breed )
{
    if ( !isdefined( breed ) )
    {
        breed = "all";
    }
    
    ai = getaispeciesarray( "allies", breed );
    ai = array_combine( ai, getaispeciesarray( "axis", breed ) );
    array = [];
    
    for ( i = 0; i < ai.size ; i++ )
    {
        switch ( type )
        {
            case #"hash_5a532485943b3d4b":
                if ( isdefined( ai[ i ].targetname ) && ai[ i ].targetname == name )
                {
                    array[ array.size ] = ai[ i ];
                }
                
                break;
            case #"hash_6d8a4db48060bf8":
                if ( isdefined( ai[ i ].script_noteworthy ) && ai[ i ].script_noteworthy == name )
                {
                    array[ array.size ] = ai[ i ];
                }
                
                break;
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5846
// Size: 0x9c
function gather_delay_proc( msg, delay )
{
    if ( isdefined( level.gather_delay[ msg ] ) )
    {
        if ( level.gather_delay[ msg ] )
        {
            wait 0.05;
            
            if ( isalive( self ) )
            {
                self notify( "gather_delay_finished" + msg + delay );
            }
            
            return;
        }
        
        level waittill( msg );
        
        if ( isalive( self ) )
        {
            self notify( "gather_delay_finished" + msg + delay );
        }
        
        return;
    }
    
    level.gather_delay[ msg ] = 0;
    wait delay;
    level.gather_delay[ msg ] = 1;
    level notify( msg );
    
    if ( isalive( self ) )
    {
        self notify( "gat    her_delay_finished" + msg + delay );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x58ea
// Size: 0x29
function gather_delay( msg, delay )
{
    thread gather_delay_proc( msg, delay );
    self waittill( "gather_delay_finished" + msg + delay );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x591b
// Size: 0x75
function getlinks_array( array, linkmap )
{
    ents = [];
    
    for ( j = 0; j < array.size ; j++ )
    {
        node = array[ j ];
        script_linkname = node.script_linkname;
        
        if ( !isdefined( script_linkname ) )
        {
            continue;
        }
        
        if ( !isdefined( linkmap[ script_linkname ] ) )
        {
            continue;
        }
        
        ents[ ents.size ] = node;
    }
    
    return ents;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5999
// Size: 0xe8
function array_merge( array1, array2 )
{
    if ( array1.size == 0 )
    {
        return array2;
    }
    
    if ( array2.size == 0 )
    {
        return array1;
    }
    
    newarray = array1;
    
    foreach ( array2_ent in array2 )
    {
        foundmatch = 0;
        
        foreach ( array1_ent in array1 )
        {
            if ( array1_ent == array2_ent )
            {
                foundmatch = 1;
                break;
            }
        }
        
        if ( foundmatch )
        {
            continue;
        }
        
        newarray[ newarray.size ] = array2_ent;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5a8a
// Size: 0x7f, Type: bool
function array_compare( array1, array2 )
{
    if ( array1.size != array2.size )
    {
        return false;
    }
    
    foreach ( key, member in array1 )
    {
        if ( !isdefined( array2[ key ] ) )
        {
            return false;
        }
        
        member2 = array2[ key ];
        
        if ( member2 != member )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x5b12
// Size: 0x1a9
function deck_draw_specific( item, var_cca1a8591ddc8a23 )
{
    assertex( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "draw_from_deck_specific() must be called on a deck. Call create_deck()" );
    deck = self;
    
    if ( deck.items.size == 0 )
    {
        return undefined;
    }
    
    if ( deck.index >= deck.items.size )
    {
        if ( deck.autoshuffle )
        {
            deck deck_shuffle();
        }
        else
        {
            deck.index = 0;
        }
    }
    
    foreach ( item_index, deck_item in deck.items )
    {
        if ( deck_item != item || !istrue( var_cca1a8591ddc8a23 ) && item_index < deck.index )
        {
            continue;
        }
        
        deck.last_drawn = deck.items[ item_index ];
        
        if ( deck.autoshuffle )
        {
            deck.items[ item_index ] = deck.items[ deck.index ];
            deck.items[ deck.index ] = deck.last_drawn;
            deck.index++;
        }
        else
        {
            deck.index = item_index + 1;
        }
        
        return deck.last_drawn;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x5cc3
// Size: 0x56
function refill_if_empty()
{
    assertex( is_deck( self ), "<dev string:x77>" );
    deck = self;
    
    if ( deck deck_is_empty() )
    {
        if ( deck.autoshuffle )
        {
            deck deck_shuffle();
            return;
        }
        
        deck.index = 0;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x5d21
// Size: 0x2e, Type: bool
function deck_is_empty()
{
    assertex( is_deck( self ), "<dev string:xb6>" );
    return self.index >= self.items.size;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x5d58
// Size: 0x31, Type: bool
function is_deck( object )
{
    return isstruct( object ) && isdefined( object.items ) && isdefined( object.index );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x5d92
// Size: 0x8e
function getlinkedvehiclenodes()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        foreach ( name in linknames )
        {
            entities = getvehiclenodearray( name, "script_linkname" );
            array = array_combine( array, entities );
        }
    }
    
    return array;
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 5
    // Checksum 0x0, Offset: 0x5e29
    // Size: 0x4a, Type: dev
    function draw_line( org1, org2, r, g, b )
    {
        while ( true )
        {
            line( org1, org2, ( r, g, b ), 1 );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x5e7b
// Size: 0x85
function draw_line_to_ent_for_time( org1, ent, r, g, b, timer )
{
    timer = gettime() + timer * 1000;
    
    while ( gettime() < timer )
    {
        /#
            line( org1, ent.origin, ( r, g, b ), 1 );
        #/
        
        wait 0.05;
        
        if ( !isdefined( ent ) || !isdefined( ent.origin ) )
        {
            return;
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x5f08
// Size: 0x40
function draw_line_from_ent_for_time( ent, org, r, g, b, timer )
{
    draw_line_to_ent_for_time( org, ent, r, g, b, timer );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x5f50
// Size: 0x86
function draw_line_from_ent_to_ent_for_time( ent1, ent2, r, g, b, timer )
{
    ent1 endon( "death" );
    ent2 endon( "death" );
    timer = gettime() + timer * 1000;
    
    while ( gettime() < timer )
    {
        /#
            line( ent1.origin, ent2.origin, ( r, g, b ), 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x5fde
// Size: 0x99
function draw_line_from_ent_to_ent_until_notify( ent1, ent2, r, g, b, notifyent, notifystring )
{
    assert( isdefined( notifyent ) );
    assert( isdefined( notifystring ) );
    ent1 endon( "death" );
    ent2 endon( "death" );
    notifyent endon( notifystring );
    
    /#
        while ( true )
        {
            line( ent1.origin, ent2.origin, ( r, g, b ), 0.05 );
            wait 0.05;
        }
    #/
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x607f
// Size: 0x6e
function draw_line_until_notify( org1, org2, r, g, b, notifyent, notifystring )
{
    assert( isdefined( notifyent ) );
    assert( isdefined( notifystring ) );
    notifyent endon( notifystring );
    
    while ( true )
    {
        draw_line_for_time( org1, org2, r, g, b, 0.05 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x60f5
// Size: 0x9f
function draw_line_from_ent_to_vec_for_time( ent, vec, length, r, g, b, timer )
{
    timer = gettime() + timer * 1000;
    vec *= length;
    
    while ( gettime() < timer )
    {
        /#
            line( ent.origin, ent.origin + vec, ( r, g, b ), 1 );
        #/
        
        wait 0.05;
        
        if ( !isdefined( ent ) || !isdefined( ent.origin ) )
        {
            return;
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x619c
// Size: 0x105
function draw_circle_until_notify( center, radius, r, g, b, notifyent, notifystring )
{
    circle_sides = 16;
    anglefrac = 360 / circle_sides;
    circlepoints = [];
    
    for ( i = 0; i < circle_sides ; i++ )
    {
        angle = anglefrac * i;
        xadd = cos( angle ) * radius;
        yadd = sin( angle ) * radius;
        x = center[ 0 ] + xadd;
        y = center[ 1 ] + yadd;
        z = center[ 2 ];
        circlepoints[ circlepoints.size ] = ( x, y, z );
    }
    
    thread draw_circle_lines_until_notify( circlepoints, r, g, b, notifyent, notifystring );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x62a9
// Size: 0x90
function draw_circle_lines_until_notify( circlepoints, r, g, b, notifyent, notifystring )
{
    for ( i = 0; i < circlepoints.size ; i++ )
    {
        start = circlepoints[ i ];
        
        if ( i + 1 >= circlepoints.size )
        {
            end = circlepoints[ 0 ];
        }
        else
        {
            end = circlepoints[ i + 1 ];
        }
        
        thread draw_line_until_notify( start, end, r, g, b, notifyent, notifystring );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6341
// Size: 0x43
function battlechatter_off( team )
{
    if ( !isdefined( team ) )
    {
        level.battlechatterdisabled = 1;
        return;
    }
    
    if ( !isdefined( level.battlechatterdisabledteams ) )
    {
        level.battlechatterdisabledteams = [];
    }
    
    level.battlechatterdisabledteams[ team ] = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x638c
// Size: 0x49
function battlechatter_on( team )
{
    if ( !isdefined( level.battlechatter ) )
    {
        scripts\anim\battlechatter::init_battlechatter();
    }
    
    if ( !isdefined( team ) )
    {
        level.battlechatterdisabled = undefined;
        return;
    }
    
    if ( isdefined( level.battlechatterdisabledteams ) )
    {
        level.battlechatterdisabledteams[ team ] = undefined;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x63dd
// Size: 0xb9
function battlechatter_commander_off( team )
{
    if ( team == "all" )
    {
        setdvar( @"hash_702217ae066916b9", "all" );
        return;
    }
    
    switch ( getdvar( @"hash_702217ae066916b9" ) )
    {
        case #"":
            setdvar( @"hash_702217ae066916b9", team );
            break;
        case #"hash_7c2d091e6337bf54":
            if ( team == "allies" )
            {
                setdvar( @"hash_702217ae066916b9", "all" );
            }
            
            break;
        case #"hash_5f54b9bf7583687f":
            if ( team == "axis" )
            {
                setdvar( @"hash_702217ae066916b9", "all" );
            }
            
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x649e
// Size: 0xe8
function battlechatter_commander_on( team )
{
    if ( team == "all" )
    {
        setdvar( @"hash_702217ae066916b9", "" );
        return;
    }
    
    switch ( getdvar( @"hash_702217ae066916b9" ) )
    {
        case #"hash_7c2d091e6337bf54":
            if ( team == "axis" )
            {
                setdvar( @"hash_702217ae066916b9", "" );
            }
            
            break;
        case #"hash_5f54b9bf7583687f":
            if ( team == "allies" )
            {
                setdvar( @"hash_702217ae066916b9", "" );
            }
            
            break;
        case #"hash_c482c6c109150a4":
            if ( team == "axis" )
            {
                setdvar( @"hash_702217ae066916b9", "allies" );
            }
            else if ( team == "allies" )
            {
                setdvar( @"hash_702217ae066916b9", "allies" );
            }
            
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x658e
// Size: 0xb9
function battlechatter_radioecho_off( team )
{
    if ( team == "all" )
    {
        setdvar( @"hash_21778f568437cd09", "all" );
        return;
    }
    
    switch ( getdvar( @"hash_21778f568437cd09" ) )
    {
        case #"":
            setdvar( @"hash_21778f568437cd09", team );
            break;
        case #"hash_7c2d091e6337bf54":
            if ( team == "allies" )
            {
                setdvar( @"hash_21778f568437cd09", "all" );
            }
            
            break;
        case #"hash_5f54b9bf7583687f":
            if ( team == "axis" )
            {
                setdvar( @"hash_21778f568437cd09", "all" );
            }
            
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x664f
// Size: 0xe8
function battlechatter_radioecho_on( team )
{
    if ( team == "all" )
    {
        setdvar( @"hash_21778f568437cd09", "" );
        return;
    }
    
    switch ( getdvar( @"hash_21778f568437cd09" ) )
    {
        case #"hash_7c2d091e6337bf54":
            if ( team == "axis" )
            {
                setdvar( @"hash_21778f568437cd09", "" );
            }
            
            break;
        case #"hash_5f54b9bf7583687f":
            if ( team == "allies" )
            {
                setdvar( @"hash_21778f568437cd09", "" );
            }
            
            break;
        case #"hash_c482c6c109150a4":
            if ( team == "axis" )
            {
                setdvar( @"hash_21778f568437cd09", "allies" );
            }
            else if ( team == "allies" )
            {
                setdvar( @"hash_21778f568437cd09", "axis" );
            }
            
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x673f
// Size: 0xb0
function battlechatter_otn_on( type, team )
{
    assertex( isdefined( type ), "No type defined.  Should be 'stealth' or 'combat'." );
    assertex( isdefined( team ), "No team defined.  Should be 'axis', 'allies' or 'all'." );
    type = tolower( type );
    team = tolower( team );
    dvar = undefined;
    
    switch ( type )
    {
        case #"hash_3d5f49f17b95335c":
            dvar = @"hash_495535a4877b324d";
            break;
        case #"hash_9e02cd4a0f3ca981":
            dvar = @"hash_87dca5163728ce02";
            break;
        default:
            assertmsg( "Incorrect type specified: " + type );
            break;
    }
    
    setdvar( dvar, team );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x67f7
// Size: 0x94
function battlechatter_otn_off( type )
{
    assertex( isdefined( type ), "No type defined.  Should be 'stealth' or 'combat'." );
    type = tolower( type );
    dvar = undefined;
    
    switch ( type )
    {
        case #"hash_3d5f49f17b95335c":
            dvar = @"hash_495535a4877b324d";
            break;
        case #"hash_9e02cd4a0f3ca981":
            dvar = @"hash_87dca5163728ce02";
            break;
        default:
            assertmsg( "Incorrect type specified: " + type );
            break;
    }
    
    setdvar( dvar, "off" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6893
// Size: 0x39
function battlechatter_probability( probability )
{
    assertex( isdefined( self ), "Must run this on an AI entity" );
    assertex( isai( self ), "Must run this on an AI entity" );
    self.battlechatter_saytimescaled = probability;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x68d4
// Size: 0x77
function battlechatter_filter_on( type )
{
    assertex( isdefined( self ), "Must run this on an entity" );
    
    if ( !isarray( type ) )
    {
        type = [ type ];
    }
    
    foreach ( t in type )
    {
        battlechatter_filter_internal( t, 1 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6953
// Size: 0x76
function battlechatter_filter_off( type )
{
    assertex( isdefined( self ), "Must run this on an entity" );
    
    if ( !isarray( type ) )
    {
        type = [ type ];
    }
    
    foreach ( t in type )
    {
        battlechatter_filter_internal( t, undefined );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x69d1
// Size: 0x118
function battlechatter_filter_internal( type, toggle )
{
    switch ( type )
    {
        case #"hash_53dc45bfe25bbb01":
            self.battlechatter.filterthreat = toggle;
            break;
        case #"hash_8c231c599933fd88":
            self.battlechatter.filterinform = toggle;
            break;
        case #"hash_b9c0ff6cd406fe0f":
            self.battlechatter.filtervehicle = toggle;
            break;
        case #"hash_92e2b89a2c37e077":
            self.battlechatter.filterorder = toggle;
            break;
        case #"hash_19b7f63b88b6888a":
            self.battlechatter.filterreaction = toggle;
            break;
        case #"hash_7f07e54152a6ce3e":
            self.battlechatter.filterresponse = toggle;
            break;
        case #"hash_3d5f49f17b95335c":
            self.battlechatter.filterstealth = toggle;
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6af1
// Size: 0x3c
function battlechatter_friendlyfire_force( bool )
{
    if ( istrue( bool ) )
    {
        self.battlechatter.friendlyfire_force = 1;
        return;
    }
    
    self.battlechatter.friendlyfire_force = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6b35
// Size: 0x53
function battlechatter_addvehicle( class )
{
    assertex( isdefined( class ), "Must defined a <class> for the vehicle, 'helicopter', 'vehicle', etc..." );
    
    if ( !isdefined( self.battlechatter ) )
    {
        self.battlechatter = spawnstruct();
    }
    
    self.battlechatter.enemyclass = class;
    thread scripts\anim\battlechatter_ai::aivehiclekillwaiter();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x6b90
// Size: 0xc8
function set_team_bcvoice( team, newvoice )
{
    if ( !anim.chatinitialized )
    {
        return;
    }
    
    var_73caaf0ec409e8d1 = getarraykeys( anim.countryids );
    var_a3f20193b82b1467 = array_contains( var_73caaf0ec409e8d1, newvoice );
    assertex( var_a3f20193b82b1467, "Tried to change ai's voice to " + newvoice + " but that voicetype is not supported!" );
    
    if ( !var_a3f20193b82b1467 )
    {
        return;
    }
    
    allies = getaiarray( team );
    
    foreach ( ai in allies )
    {
        ai set_ai_bcvoice( newvoice );
        waitframe();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6c60
// Size: 0xa1
function set_ai_bcvoice( newvoice )
{
    var_73caaf0ec409e8d1 = getarraykeys( anim.countryids );
    var_a3f20193b82b1467 = array_contains( var_73caaf0ec409e8d1, newvoice );
    assertex( var_a3f20193b82b1467, "Tried to change ai's voice to " + newvoice + " but that voicetype is not supported!" );
    
    if ( !var_a3f20193b82b1467 )
    {
        return;
    }
    
    if ( self.type == "dog" )
    {
        return;
    }
    
    if ( isdefined( self.battlechatter ) && istrue( self.battlechatter.isspeaking ) )
    {
        self waittill( "done speaking" );
        wait 0.1;
    }
    
    scripts\anim\battlechatter_ai::setvoice( newvoice );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6d09
// Size: 0x16
function flavorbursts_on( team )
{
    thread set_flavorbursts_team_state( 1, team );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6d27
// Size: 0x15
function flavorbursts_off( team )
{
    thread set_flavorbursts_team_state( 0, team );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x6d44
// Size: 0x77
function set_flavorbursts_team_state( state, team )
{
    if ( !isdefined( team ) )
    {
        team = "allies";
    }
    
    while ( !isdefined( anim.chatinitialized ) )
    {
        wait 0.05;
    }
    
    if ( !anim.chatinitialized )
    {
        return;
    }
    
    wait 1.5;
    level.flavorbursts[ team ] = state;
    guys = [];
    guys = getaiarray( team );
    array_thread( guys, &set_flavorbursts, state );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6dc3
// Size: 0x15
function set_flavorbursts( state )
{
    self.flavorbursts = state;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x6de0
// Size: 0x74
function friendlyfire_warnings_off()
{
    ais = getaiarray( "allies" );
    
    foreach ( guy in ais )
    {
        if ( isalive( guy ) )
        {
            guy set_friendlyfire_warnings( 0 );
        }
    }
    
    level.friendlyfire_warnings = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x6e5c
// Size: 0x76
function friendlyfire_warnings_on()
{
    ais = getaiarray( "allies" );
    
    foreach ( guy in ais )
    {
        if ( isalive( guy ) )
        {
            guy set_friendlyfire_warnings( 1 );
        }
    }
    
    level.friendlyfire_warnings = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6eda
// Size: 0x27
function set_friendlyfire_warnings( state )
{
    if ( state )
    {
        self.friendlyfire_warnings_disable = undefined;
        return;
    }
    
    self.friendlyfire_warnings_disable = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x6f09
// Size: 0xa
function player_battlechatter_on()
{
    thread scripts\sp\player\playerchatter::player_battlechatter_on_thread();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x6f1b
// Size: 0xa
function player_battlechatter_off()
{
    thread scripts\sp\player\playerchatter::player_battlechatter_off_thread();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6f2d
// Size: 0x1f
function set_name( name )
{
    self.name = name;
    self.ainame = name;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6f54
// Size: 0x1f
function set_rank( rank )
{
    self.rank = rank;
    self.airank = rank;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x6f7b
// Size: 0x15
function set_callsign( callsign )
{
    self.callsign = callsign;
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 0
    // Checksum 0x0, Offset: 0x6f98
    // Size: 0x115, Type: dev
    function debugorigin()
    {
        self notify( "<dev string:xf3>" );
        self endon( "<dev string:xf3>" );
        self endon( "<dev string:x100>" );
        
        for ( ;; )
        {
            forward = anglestoforward( self.angles );
            forwardfar = forward * 30;
            forwardclose = forward * 20;
            right = anglestoright( self.angles );
            left = right * -10;
            right *= 10;
            line( self.origin, self.origin + forwardfar, ( 0.9, 0.7, 0.6 ), 0.9 );
            line( self.origin + forwardfar, self.origin + forwardclose + right, ( 0.9, 0.7, 0.6 ), 0.9 );
            line( self.origin + forwardfar, self.origin + forwardclose + left, ( 0.9, 0.7, 0.6 ), 0.9 );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x70b5
// Size: 0x38
function get_linked_struct()
{
    array = get_linked_structs();
    
    if ( !array.size )
    {
        return undefined;
    }
    
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x70f6
// Size: 0x79
function get_last_ent_in_chain( sentitytype )
{
    epathpoint = self;
    cycles = 0;
    
    while ( isdefined( epathpoint.target ) )
    {
        if ( isdefined( epathpoint.target ) )
        {
            epathpoint = get_next_point_in_chain( sentitytype, epathpoint.target );
            cycles++;
            
            if ( cycles == 10 )
            {
                waitframe();
                cycles = 0;
            }
            
            continue;
        }
        
        break;
    }
    
    epathend = epathpoint;
    return epathend;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7178
// Size: 0x10f
function get_next_point_in_chain( sentitytype, tname )
{
    epathpoint = undefined;
    
    if ( isdefined( sentitytype ) )
    {
        switch ( sentitytype )
        {
            case #"hash_73214da7c956e2af":
                epathpoint = getvehiclenode( tname, "targetname" );
                break;
            case #"hash_d2886253a54aa2e2":
                epathpoint = getnode( tname, "targetname" );
                break;
            case #"hash_ed49a46bfff900ba":
                epathpoint = getent( tname, "targetname" );
                break;
            case #"hash_961a09cded5ffc80":
                epathpoint = getstruct( tname, "targetname" );
                break;
            default:
                assertmsg( "sEntityType needs to be 'vehiclenode', 'pathnode', 'ent' or 'struct'" );
                break;
        }
        
        return epathpoint;
    }
    else
    {
        epathpoint = getstruct( tname, "targetname" );
        
        if ( isdefined( epathpoint ) )
        {
            return epathpoint;
        }
        
        epathpoint = getnode( tname, "targetname" );
        
        if ( isdefined( epathpoint ) )
        {
            return epathpoint;
        }
        
        epathpoint = getent( tname, "targetname" );
        
        if ( isdefined( epathpoint ) )
        {
            return epathpoint;
        }
        
        epathpoint = getvehiclenode( tname, "targetname" );
        
        if ( isdefined( epathpoint ) )
        {
            return epathpoint;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7290
// Size: 0x1c
function timeout( timeout )
{
    self endon( "death" );
    wait timeout;
    self notify( "timeout" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x72b4
// Size: 0x65
function array_removedead_keepkeys( array )
{
    newarray = [];
    keys = getarraykeys( array );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        key = keys[ i ];
        
        if ( !isalive( array[ key ] ) )
        {
            continue;
        }
        
        newarray[ key ] = array[ key ];
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7322
// Size: 0x49
function array_remove_nokeys( ents, remover )
{
    newents = [];
    
    for ( i = 0; i < ents.size ; i++ )
    {
        if ( ents[ i ] != remover )
        {
            newents[ newents.size ] = ents[ i ];
        }
    }
    
    return newents;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7374
// Size: 0xd7
function array_remove_key_array( array, var_1011630871825fb8 )
{
    if ( var_1011630871825fb8.size == 0 )
    {
        return array;
    }
    
    newarray = [];
    
    foreach ( key, item in array )
    {
        found = 0;
        
        foreach ( var_b3e77f92460be011 in var_1011630871825fb8 )
        {
            if ( var_b3e77f92460be011 == key )
            {
                found = 1;
                break;
            }
        }
        
        if ( found )
        {
            continue;
        }
        
        newarray[ key ] = item;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x7454
// Size: 0x61
function array_notify( ents, notifier, match )
{
    foreach ( value in ents )
    {
        value notify( notifier, match );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x74bd
// Size: 0x2d
function struct_arrayspawn()
{
    struct = spawnstruct();
    struct.array = [];
    struct.lastindex = 0;
    return struct;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x74f3
// Size: 0x65
function structarray_add( struct, object )
{
    assert( !isdefined( object.struct_array_index ) );
    struct.array[ struct.lastindex ] = object;
    object.struct_array_index = struct.lastindex;
    struct.lastindex++;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7560
// Size: 0x42
function structarray_remove( struct, object )
{
    structarray_swaptolast( struct, object );
    struct.array[ struct.lastindex - 1 ] = undefined;
    struct.lastindex--;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x75aa
// Size: 0xbc
function structarray_remove_index( struct, index )
{
    if ( isdefined( struct.array[ struct.lastindex - 1 ] ) )
    {
        struct.array[ index ] = struct.array[ struct.lastindex - 1 ];
        struct.array[ index ].struct_array_index = index;
        struct.array[ struct.lastindex - 1 ] = undefined;
        struct.lastindex = struct.array.size;
        return;
    }
    
    struct.array[ index ] = undefined;
    structarray_remove_undefined( struct );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x766e
// Size: 0xe4
function structarray_remove_undefined( struct )
{
    newarray = [];
    
    foreach ( object in struct.array )
    {
        if ( !isdefined( object ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = object;
    }
    
    struct.array = newarray;
    
    foreach ( object in struct.array )
    {
        object.struct_array_index = i;
    }
    
    struct.lastindex = struct.array.size;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x775a
// Size: 0x36
function structarray_swaptolast( struct, object )
{
    struct structarray_swap( struct.array[ struct.lastindex - 1 ], object );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7798
// Size: 0x5c
function structarray_shuffle( struct, shuffle )
{
    for ( i = 0; i < shuffle ; i++ )
    {
        struct structarray_swap( struct.array[ i ], struct.array[ randomint( struct.lastindex ) ] );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x77fc
// Size: 0x12
function custom_battlechatter( phrase )
{
    return scripts\anim\battlechatter_ai::custom_battlechatter_internal( phrase );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7817
// Size: 0xdc
function get_stop_watch( time, othertime )
{
    watch = newhudelem();
    
    if ( isplatformconsole() )
    {
        watch.x = 68;
        watch.y = 35;
    }
    else
    {
        watch.x = 58;
        watch.y = 95;
    }
    
    watch.alignx = "center";
    watch.aligny = "middle";
    watch.horzalign = "left";
    watch.vertalign = "middle";
    
    if ( isdefined( othertime ) )
    {
        timer = othertime;
    }
    else
    {
        timer = level.explosiveplanttime;
    }
    
    watch setclock( timer, time, "hudStopwatch", 64, 64 );
    return watch;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x78fc
// Size: 0x3e
function set_mission_failed_override( func )
{
    assertex( isdefined( func ), "function handler not defined in call to add_mission_failed_override()" );
    assertex( !isdefined( level.mission_fail_func ), "mission failed override already exists." );
    level.mission_fail_func = func;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x7942
// Size: 0x83
function get_force_color_guys( team, color )
{
    ai = getaiarray( team );
    guys = [];
    
    for ( i = 0; i < ai.size ; i++ )
    {
        guy = ai[ i ];
        
        if ( !isdefined( guy.script_forcecolor ) )
        {
            continue;
        }
        
        if ( guy.script_forcecolor != color )
        {
            continue;
        }
        
        guys[ guys.size ] = guy;
    }
    
    return guys;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x79ce
// Size: 0x63
function get_all_force_color_friendlies()
{
    ai = getaiarray( "allies" );
    guys = [];
    
    for ( i = 0; i < ai.size ; i++ )
    {
        guy = ai[ i ];
        
        if ( !isdefined( guy.script_forcecolor ) )
        {
            continue;
        }
        
        guys[ guys.size ] = guy;
    }
    
    return guys;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7a3a
// Size: 0x38
function enable_ai_color()
{
    if ( isdefined( self.script_forcecolor ) )
    {
        return;
    }
    
    if ( !isdefined( self.old_forcecolor ) )
    {
        return;
    }
    
    set_force_color( self.old_forcecolor );
    self.old_forcecolor = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7a7a
// Size: 0x14
function enable_ai_color_dontmove()
{
    self.dontcolormove = 1;
    enable_ai_color();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7a96
// Size: 0xc8
function disable_ai_color()
{
    if ( isdefined( self.new_force_color_being_set ) )
    {
        self endon( "death" );
        self waittill( "done_setting_new_color" );
    }
    
    self clearfixednodesafevolume();
    
    if ( !isdefined( self.script_forcecolor ) )
    {
        return;
    }
    
    assertex( !isdefined( self.old_forcecolor ), "Tried to disable forcecolor on a guy that somehow had a old_forcecolor already. Investigate!!!" );
    self.old_forcecolor = self.script_forcecolor;
    level.arrays_of_colorforced_ai[ scripts\sp\colors::get_team() ][ self.script_forcecolor ] = array_remove( level.arrays_of_colorforced_ai[ scripts\sp\colors::get_team() ][ self.script_forcecolor ], self );
    scripts\sp\colors::left_color_node();
    self.script_forcecolor = undefined;
    self.currentcolorcode = undefined;
    
    /#
        update_debug_friendlycolor( self.unique_id );
    #/
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7b66
// Size: 0x9
function clear_force_color()
{
    disable_ai_color();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7b77
// Size: 0x17
function get_force_color()
{
    color = self.script_forcecolor;
    return color;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7b97
// Size: 0x3c
function shortencolor( color )
{
    assertex( isdefined( level.colorchecklist[ tolower( color ) ] ), "Tried to set force color on an undefined color: " + color );
    return level.colorchecklist[ tolower( color ) ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7bdc
// Size: 0x16a
function set_force_color( _color )
{
    color = shortencolor( _color );
    assertex( scripts\sp\colors::colorislegit( color ), "Tried to set force color on an undefined color: " + color );
    
    if ( !isai( self ) )
    {
        set_force_color_spawner( color );
        return;
    }
    
    assertex( isalive( self ), "Tried to set force color on a dead / undefined entity." );
    
    if ( self.team == "allies" )
    {
        self.fixednode = 1;
        self.fixednodesaferadius = 64;
        self.pathenemyfightdist = 0;
        self.pathenemylookahead = 0;
    }
    
    self.script_color_axis = undefined;
    self.script_color_allies = undefined;
    self.old_forcecolor = undefined;
    team = scripts\sp\colors::get_team();
    
    if ( isdefined( self.script_forcecolor ) )
    {
        level.arrays_of_colorforced_ai[ team ][ self.script_forcecolor ] = array_remove( level.arrays_of_colorforced_ai[ team ][ self.script_forcecolor ], self );
    }
    
    self.script_forcecolor = color;
    level.arrays_of_colorforced_ai[ team ][ color ] = array_removedead( level.arrays_of_colorforced_ai[ team ][ color ] );
    level.arrays_of_colorforced_ai[ team ][ self.script_forcecolor ] = array_add( level.arrays_of_colorforced_ai[ team ][ self.script_forcecolor ], self );
    thread new_color_being_set( color );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7d4e
// Size: 0x1f
function set_force_color_spawner( color )
{
    self.script_forcecolor = color;
    self.old_forcecolor = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x7d75
// Size: 0x9
function restarteffect()
{
    scripts\common\createfx::restart_fx_looper();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7d86
// Size: 0x78
function pauseexploder( num )
{
    num += "";
    exploders = level.createfxexploders[ num ];
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            ent pauseeffect();
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7e06
// Size: 0x78
function restartexploder( num )
{
    num += "";
    exploders = level.createfxexploders[ num ];
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            ent restarteffect();
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x7e86
// Size: 0x266
function ignoreallenemies( qtrue )
{
    self notify( "ignoreAllEnemies_threaded" );
    self endon( "ignoreAllEnemies_threaded" );
    
    if ( qtrue )
    {
        self.old_threat_bias_group = self getthreatbiasgroup();
        num = undefined;
        
        /#
            num = self getentnum();
            println( "<dev string:x106>" + num + "<dev string:x10f>" );
            println( "<dev string:x106>" + num + "<dev string:x125>" + self.old_threat_bias_group );
        #/
        
        createthreatbiasgroup( "ignore_everybody" );
        
        /#
            println( "<dev string:x106>" + num + "<dev string:x10f>" );
            println( "<dev string:x106>" + num + "<dev string:x13a>" );
        #/
        
        self setthreatbiasgroup( "ignore_everybody" );
        teams = [];
        teams[ "axis" ] = "allies";
        teams[ "allies" ] = "axis";
        assertex( self.team != "neutral", "Why are you making a guy have team neutral? And also, why is he doing anim_reach?" );
        ai = getaiarray( teams[ self.team ] );
        groups = [];
        
        for ( i = 0; i < ai.size ; i++ )
        {
            groups[ ai[ i ] getthreatbiasgroup() ] = 1;
        }
        
        keys = getarraykeys( groups );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            /#
                println( "<dev string:x106>" + num + "<dev string:x10f>" );
                println( "<dev string:x106>" + num + "<dev string:x162>" + keys[ i ] + "<dev string:x173>" );
            #/
            
            setthreatbias( keys[ i ], "ignore_everybody", 0 );
        }
        
        return;
    }
    
    num = undefined;
    assertex( isdefined( self.old_threat_bias_group ), "You can't use ignoreAllEnemies( false ) on an AI that has never ran ignoreAllEnemies( true )" );
    
    /#
        num = self getentnum();
        println( "<dev string:x106>" + num + "<dev string:x18b>" );
        println( "<dev string:x106>" + num + "<dev string:x1a2>" + self.old_threat_bias_group );
    #/
    
    if ( self.old_threat_bias_group != "" )
    {
        /#
            println( "<dev string:x106>" + num + "<dev string:x18b>" );
            println( "<dev string:x106>" + num + "<dev string:x1c2>" + self.old_threat_bias_group + "<dev string:x1d8>" );
        #/
        
        self setthreatbiasgroup( self.old_threat_bias_group );
    }
    
    self.old_threat_bias_group = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x80f4
// Size: 0x98
function add_start( msg, setup_func, main_func, transient, catchup_function )
{
    add_start_assert();
    msg = tolower( msg );
    assertex( !isstring( main_func ), "The loc_string parameter has been removed from add_start! Please remove that argument from your script!" );
    array = add_start_construct( msg, setup_func, main_func, transient, catchup_function );
    assertex( isdefined( setup_func ), "add_start() called with no descriptions set and no func parameter.." );
    level.start_functions[ level.start_functions.size ] = array;
    level.start_arrays[ msg ] = array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8194
// Size: 0x1a
function set_default_start( start )
{
    level.default_start_override = tolower( start );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x81b6
// Size: 0x1a
function set_default_start_alt( start )
{
    level.default_start_override_alt = tolower( start );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x81d8
// Size: 0x7e, Type: bool
function within_fov_of_players( end_origin, fov )
{
    var_b17d99b17c3501ed = undefined;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        playereye = level.players[ i ] geteye();
        var_b17d99b17c3501ed = within_fov( playereye, level.players[ i ] getplayerangles(), end_origin, fov );
        
        if ( !var_b17d99b17c3501ed )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x825f
// Size: 0x3c
function wait_for_buffer_time_to_pass( last_queue_time, buffer_time )
{
    timer = buffer_time * 1000 - gettime() - last_queue_time;
    timer *= 0.001;
    
    if ( timer > 0 )
    {
        wait timer;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x82a3
// Size: 0x10
function bcs_scripted_dialogue_start()
{
    anim.scripteddialoguestarttime = gettime();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x82bb
// Size: 0x1b
function dialogue_queue( msg )
{
    bcs_scripted_dialogue_start();
    scripts\sp\anim::anim_single_queue( self, msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x82de
// Size: 0x26
function generic_dialogue_queue( msg, timeout )
{
    bcs_scripted_dialogue_start();
    scripts\sp\anim::anim_generic_queue( self, msg, undefined, undefined, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x830c
// Size: 0x12c
function radio_dialogue( msg, timeout )
{
    /#
        assertex( isdefined( level.scr_radio[ msg ] ), "<dev string:x1db>" + msg + "<dev string:x1f9>" );
        assertex( !issound3d( level.scr_radio[ msg ] ), "<dev string:x228>" + msg + "<dev string:x242>" );
    #/
    
    if ( !isdefined( level.player_radio_emitter ) )
    {
        ent = spawn( "script_origin", ( 0, 0, 0 ) );
        ent linkto( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.player_radio_emitter = ent;
    }
    
    bcs_scripted_dialogue_start();
    success = 0;
    
    if ( !isdefined( timeout ) )
    {
        success = level.player_radio_emitter function_stack( &playsoundontag, level.scr_radio[ msg ], undefined, 1 );
    }
    else
    {
        success = level.player_radio_emitter function_stack_timeout( timeout, &playsoundontag, level.scr_radio[ msg ], undefined, 1 );
    }
    
    return success;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8441
// Size: 0x63
function radio_dialogue_overlap( msg )
{
    assertex( isdefined( level.scr_radio[ msg ] ), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio" );
    assertex( isdefined( level.player_radio_emitter ), "Tried to overlap dialogue but no radio dialogue was playing, use radio_dialogue." );
    level.player_radio_emitter play_sound_on_tag( level.scr_radio[ msg ], undefined, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x84ac
// Size: 0x1f
function radio_dialogue_stop()
{
    if ( !isdefined( level.player_radio_emitter ) )
    {
        return;
    }
    
    level.player_radio_emitter delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x84d3
// Size: 0x20
function radio_dialogue_clear_stack()
{
    if ( !isdefined( level.player_radio_emitter ) )
    {
        return;
    }
    
    level.player_radio_emitter function_stack_clear();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x84fb
// Size: 0xb3
function radio_dialogue_interupt( msg )
{
    assertex( isdefined( level.scr_radio[ msg ] ), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio" );
    
    if ( !isdefined( level.player_radio_emitter ) )
    {
        ent = spawn( "script_origin", ( 0, 0, 0 ) );
        ent linkto( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.player_radio_emitter = ent;
    }
    
    level.player_radio_emitter play_sound_on_tag( level.scr_radio[ msg ], undefined, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x85b6
// Size: 0x17
function radio_dialogue_safe( msg )
{
    return radio_dialogue( msg, 0.05 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x85d6
// Size: 0x24
function smart_radio_dialogue( dialogue, timeout )
{
    add_to_radio( dialogue );
    radio_dialogue( dialogue, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8602
// Size: 0x22
function smart_radio_dialogue_interrupt( dialogue )
{
    add_to_radio( dialogue );
    radio_dialogue_stop();
    radio_dialogue_interupt( dialogue );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x862c
// Size: 0x1b
function smart_radio_dialogue_overlap( dialogue )
{
    add_to_radio( dialogue );
    radio_dialogue_overlap( dialogue );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x864f
// Size: 0x1f
function player_dialogue( msg, timeout )
{
    return player_dialogue_gesture( msg, 0, undefined, undefined, undefined, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x8677
// Size: 0x1e4
function _play_player_dialogue( alias, sounddelay, gestures, gesturedelays, gesturetargets )
{
    if ( is_dead_sentient() )
    {
        return;
    }
    
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( "death" );
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto( self );
    
    /#
        if ( isdefined( level.player_dialogue_emitter ) && self == level.player_dialogue_emitter )
        {
            println( "<dev string:x255>" + alias );
        }
    #/
    
    if ( sounddelay > 0 )
    {
        org delaycall( sounddelay, &playsound, alias, "sounddone" );
    }
    else
    {
        org playsound( alias, "sounddone" );
    }
    
    if ( isdefined( gestures ) )
    {
        assert( isdefined( gesturedelays ), "Tried to play player dialogue with gestures, but gestureDelays was not defined!" );
        
        if ( isarray( gestures ) )
        {
            assertex( gestures.size == gesturedelays.size, "Tried to play player dialogue but gestures and gestureDelays arrays were of different sizes!" );
            
            for ( i = 0; i < gestures.size ; i++ )
            {
                if ( isdefined( gesturetargets ) && isdefined( gesturetargets[ i ] ) )
                {
                    level.player delaythread( gesturedelays[ i ], &player_gesture_force, gestures[ i ], gesturetargets[ i ] );
                    continue;
                }
                
                level.player delaythread( gesturedelays[ i ], &player_gesture_force, gestures[ i ] );
            }
        }
        else if ( isdefined( gesturetargets ) )
        {
            level.player delaythread( gesturedelays, &player_gesture_force, gestures, gesturetargets );
        }
        else
        {
            level.player delaythread( gesturedelays, &player_gesture_force, gestures );
        }
    }
    
    if ( sounddelay > 0 )
    {
        wait sounddelay;
    }
    
    if ( !isdefined( wait_for_sounddone_or_death( org, level.player ) ) )
    {
        org stopsounds();
    }
    
    wait 0.05;
    org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x8863
// Size: 0x12a
function player_dialogue_gesture( msg, sounddelay, gestures, gesturedelays, targetents, timeout )
{
    assertex( isdefined( level.scr_plrdialogue[ msg ] ), "Tried to play player dialogue " + msg + " that did not exist! Add it to level.scr_plrDialogue" );
    
    if ( !isdefined( level.player_dialogue_emitter ) )
    {
        ent = spawn( "script_origin", ( 0, 0, 0 ) );
        ent linkto( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.player_dialogue_emitter = ent;
    }
    
    bcs_scripted_dialogue_start();
    success = 0;
    
    if ( !isdefined( timeout ) )
    {
        success = level.player_dialogue_emitter function_stack( &_play_player_dialogue, level.scr_plrdialogue[ msg ], sounddelay, gestures, gesturedelays, targetents );
    }
    else
    {
        success = level.player_dialogue_emitter function_stack_timeout( timeout, &_play_player_dialogue, level.scr_plrdialogue[ msg ], sounddelay, gestures, gesturedelays, targetents );
    }
    
    return success;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x8996
// Size: 0x1f
function player_dialogue_stop()
{
    if ( !isdefined( level.player_dialogue_emitter ) )
    {
        return;
    }
    
    level.player_dialogue_emitter delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x89bd
// Size: 0x20
function player_dialogue_clear_stack()
{
    if ( !isdefined( level.player_dialogue_emitter ) )
    {
        return;
    }
    
    level.player_dialogue_emitter function_stack_clear();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x89e5
// Size: 0xb8
function player_dialogue_interrupt( msg )
{
    assertex( isdefined( level.scr_plrdialogue[ msg ] ), "Tried to play player dialogue " + msg + " that did not exist! Add it to level.scr_plrDialogue" );
    player_dialogue_stop();
    
    if ( !isdefined( level.player_dialogue_emitter ) )
    {
        ent = spawn( "script_origin", ( 0, 0, 0 ) );
        ent linkto( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.player_dialogue_emitter = ent;
    }
    
    level.player_dialogue_emitter _play_player_dialogue( level.scr_plrdialogue[ msg ], 0 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x8aa5
// Size: 0x24
function smart_player_dialogue( dialogue, timeout )
{
    add_to_player_dialogue( dialogue );
    player_dialogue( dialogue, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8ad1
// Size: 0x1b
function smart_player_dialogue_interrupt( dialogue )
{
    add_to_player_dialogue( dialogue );
    player_dialogue_interrupt( dialogue );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x8af4
// Size: 0x48
function smart_player_dialogue_gesture( dialogue, sounddelay, gestures, gesturedelays, targetents, timeout )
{
    add_to_player_dialogue( dialogue );
    player_dialogue_gesture( dialogue, sounddelay, gestures, gesturedelays, targetents, timeout );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8b44
// Size: 0x1b
function smart_dialogue( dialogue )
{
    add_to_dialogue( dialogue );
    dialogue_queue( dialogue );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8b67
// Size: 0x1b
function smart_dialogue_generic( dialogue )
{
    add_to_dialogue_generic( dialogue );
    generic_dialogue_queue( dialogue );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x8b8a
// Size: 0x26b
function dialogue_print( dialogue, overradio, clearcurrent, maxlines )
{
    if ( !isdefined( maxlines ) && isdefined( level.var_e45d4b8e1cc3925c ) )
    {
        maxlines = level.var_e45d4b8e1cc3925c;
    }
    
    assert( !isdefined( maxlines ) || maxlines >= 1, "Dialogue print max lines must be at least 1." );
    
    if ( istrue( clearcurrent ) && isdefined( level.dialoguehud ) || isdefined( maxlines ) && isdefined( level.dialoguehud ) && level.dialoguehud.size >= maxlines )
    {
        dialogue_print_clear( 1, maxlines - 1 );
    }
    
    if ( isplayer( self ) )
    {
        color = "^3";
    }
    else if ( isdefined( self.team ) )
    {
        switch ( self.team )
        {
            case #"hash_7c2d091e6337bf54":
                color = "^1";
                break;
            case #"hash_5f54b9bf7583687f":
                color = "^5";
                break;
            case #"hash_24b14065e10b1f8d":
                color = "^4";
                break;
            default:
                color = "^2";
                break;
        }
    }
    else
    {
        color = "^2";
    }
    
    print_str = "";
    
    if ( isdefined( self.name ) )
    {
        print_str += self.name;
    }
    else if ( isplayer( self ) )
    {
        print_str += "Player";
    }
    else if ( isdefined( self.team ) )
    {
        if ( isdefined( level.var_76fed2ad3db8bb83 ) && isdefined( level.var_76fed2ad3db8bb83[ self.team ] ) )
        {
            print_str += level.var_76fed2ad3db8bb83[ self.team ];
        }
        else
        {
            switch ( self.team )
            {
                case #"hash_7c2d091e6337bf54":
                    print_str += "Enemy";
                    break;
                case #"hash_24b14065e10b1f8d":
                    print_str += "Team3";
                    break;
                case #"hash_5f54b9bf7583687f":
                    print_str += "Friendly";
                    break;
                default:
                    print_str += "Civ";
                    break;
            }
        }
    }
    
    if ( istrue( overradio ) )
    {
        print_str += " Over Radio";
    }
    
    if ( print_str != "" )
    {
        print_str = color + print_str + ": ^7";
    }
    
    print_str += dialogue;
    thread function_ea8bbcc7fb7ae790( print_str );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x8dfd
// Size: 0x543
function function_ea8bbcc7fb7ae790( string )
{
    var_b54520c420443a7c = int( 5.9 );
    lineheight = int( 10 );
    var_7794fdd4649e6d7f = int( 4 );
    
    if ( isdefined( level.var_eecd069bb8d057c5 ) )
    {
        endy = level.var_eecd069bb8d057c5;
    }
    else
    {
        endy = 425;
    }
    
    width = int( clamp( string.size * var_b54520c420443a7c, 350, 630 ) );
    string_array = wrap_text( string, int( 630 / var_b54520c420443a7c ) );
    height = lineheight * string_array.size + var_7794fdd4649e6d7f * 2;
    text_array = [];
    
    foreach ( i, string in string_array )
    {
        text = newhudelem();
        text.alpha = 0;
        text settext( string );
        text.fontscale = 1;
        text.row = i;
        text.y = 425;
        text_array[ text_array.size ] = text;
    }
    
    bg = newhudelem();
    bg.alpha = 0;
    bg setshader( "black", width, height );
    bg.y = 425;
    
    if ( isdefined( level.dialoguehud ) )
    {
        foreach ( dialogueline in level.dialoguehud )
        {
            foreach ( hud in dialogueline )
            {
                hud moveovertime( 0.1 );
                hud.y -= height + 5;
            }
        }
    }
    else
    {
        level.dialoguehud = [];
    }
    
    array = array_add( text_array, bg );
    array[ 0 ] endon( "dialogue_print_clear" );
    level.dialoguehud[ level.dialoguehud.size ] = array;
    
    foreach ( hud in array )
    {
        hud.alignx = "center";
        hud.aligny = "top";
        hud.x = 320;
        hud.y = 425;
        hud.sort = 5;
        
        if ( isdefined( hud.row ) )
        {
            hud.y += hud.row * lineheight + var_7794fdd4649e6d7f;
        }
    }
    
    endy -= height;
    
    foreach ( hud in array )
    {
        hud fadeovertime( 0.1 );
        
        if ( isdefined( hud.row ) )
        {
            hud.alpha = 1;
        }
        else
        {
            hud.alpha = 0.5;
        }
        
        hud moveovertime( 0.1 );
        
        if ( isdefined( hud.row ) )
        {
            hud.y = endy + hud.row * lineheight + var_7794fdd4649e6d7f;
            continue;
        }
        
        hud.y = endy;
    }
    
    wait 2.1;
    
    foreach ( hud in array )
    {
        hud fadeovertime( 1 );
        hud.alpha = 0;
    }
    
    wait 1;
    
    foreach ( dialogueline in level.dialoguehud )
    {
        if ( dialogueline[ 0 ] == array[ 0 ] )
        {
            level.dialoguehud = array_remove_index( level.dialoguehud, i, 0 );
            break;
        }
    }
    
    if ( !level.dialoguehud.size )
    {
        level.dialoguehud = undefined;
    }
    
    foreach ( hud in array )
    {
        hud destroy();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9348
// Size: 0x2b
function dialogue_print_clear( immediate, maxlines )
{
    if ( !isdefined( level.dialoguehud ) )
    {
        return;
    }
    
    thread function_bbb6c68122529e12( immediate, maxlines );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x937b
// Size: 0x21e
function function_bbb6c68122529e12( immediate, maxlines )
{
    if ( !isdefined( maxlines ) )
    {
        maxlines = 0;
    }
    
    linestoclear = [];
    currentlines = level.dialoguehud.size;
    
    for ( i = 0; i < currentlines && currentlines - linestoclear.size > maxlines ; i++ )
    {
        level.dialoguehud[ i ][ 0 ] notify( "dialogue_print_clear" );
        linestoclear[ linestoclear.size ] = level.dialoguehud[ i ];
        level.dialoguehud = array_remove_index( level.dialoguehud, i, 1 );
    }
    
    level.dialoguehud = array_combine( level.dialoguehud );
    
    if ( !istrue( immediate ) )
    {
        foreach ( dialogueline in linestoclear )
        {
            foreach ( hud in dialogueline )
            {
                if ( hud.alpha > 0 )
                {
                    hud fadeovertime( 1 );
                    hud.alpha = 0;
                }
            }
        }
        
        wait 1;
    }
    
    if ( isdefined( level.dialoguehud ) && !level.dialoguehud.size )
    {
        level.dialoguehud = undefined;
    }
    
    foreach ( dialogueline in linestoclear )
    {
        foreach ( hud in dialogueline )
        {
            if ( isdefined( hud ) )
            {
                hud destroy();
            }
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x95a1
// Size: 0x10b
function function_ddb9b7389886bcf2( y )
{
    if ( !isdefined( y ) )
    {
        y = 425;
    }
    
    if ( isdefined( level.dialoguehud ) )
    {
        if ( isdefined( level.var_eecd069bb8d057c5 ) )
        {
            prevy = level.var_eecd069bb8d057c5;
        }
        else
        {
            prevy = 425;
        }
        
        offset = y - prevy;
        
        foreach ( dialogueline in level.dialoguehud )
        {
            foreach ( hud in dialogueline )
            {
                hud.y += offset;
            }
        }
    }
    
    level.var_eecd069bb8d057c5 = y;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x96b4
// Size: 0xd4
function function_3deaf9fa976abf79( guy )
{
    if ( isdefined( level.battlechatter[ guy.team ] ) && !istrue( level.battlechatter[ guy.team ] ) )
    {
        return;
    }
    
    level notify( "dialogue_print_battlechatter" );
    team = guy.team;
    waitframe();
    waittime = 3.1;
    
    if ( isdefined( team ) )
    {
        level battlechatter_off( team );
        level waittill_any_timeout( waittime, "dialogue_print_clear", "dialogue_print_battlechatter" );
        level battlechatter_on( team );
        return;
    }
    
    if ( isdefined( guy ) )
    {
        guy endon( "death" );
        guy endon( "entitydeleted" );
        guy set_battlechatter( 0 );
        level waittill_any_timeout( waittime, "dialogue_print_clear", "dialogue_print_battlechatter" );
        guy set_battlechatter( 1 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9790
// Size: 0x13
function radio_dialogue_queue( msg )
{
    radio_dialogue( msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x97ab
// Size: 0x7b
function ignoreeachother( group1, group2 )
{
    assertex( threatbiasgroupexists( group1 ), "Tried to make threatbias group " + group1 + " ignore " + group2 + " but " + group1 + " does not exist!" );
    assertex( threatbiasgroupexists( group2 ), "Tried to make threatbias group " + group2 + " ignore " + group1 + " but " + group2 + " does not exist!" );
    setignoremegroup( group1, group2 );
    setignoremegroup( group2, group1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x982e
// Size: 0x8d
function add_global_spawn_function( team, function, param1, param2, param3 )
{
    assertex( isdefined( level.spawn_funcs ), "Tried to add_global_spawn_function before calling _load" );
    func = [];
    func[ "function" ] = function;
    func[ "param1" ] = param1;
    func[ "param2" ] = param2;
    func[ "param3" ] = param3;
    level.spawn_funcs[ team ][ level.spawn_funcs[ team ].size ] = func;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x98c3
// Size: 0x91
function remove_global_spawn_function( team, function )
{
    assertex( isdefined( level.spawn_funcs ), "Tried to remove_global_spawn_function before calling _load" );
    array = [];
    
    for ( i = 0; i < level.spawn_funcs[ team ].size ; i++ )
    {
        if ( level.spawn_funcs[ team ][ i ][ "function" ] != function )
        {
            array[ array.size ] = level.spawn_funcs[ team ][ i ];
        }
    }
    
    level.spawn_funcs[ team ] = array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x995c
// Size: 0x61, Type: bool
function exists_global_spawn_function( team, function )
{
    if ( !isdefined( level.spawn_funcs ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.spawn_funcs[ team ].size ; i++ )
    {
        if ( level.spawn_funcs[ team ][ i ][ "function" ] == function )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x99c6
// Size: 0xc0
function remove_spawn_function( function )
{
    assertex( !isalive( self ), "Tried to remove_spawn_function to a living guy." );
    assertex( isspawner( self ), "Tried to remove_spawn_function to something that isn't a spawner." );
    assertex( isdefined( self.spawn_functions ), "Tried to remove_spawn_function before calling _load" );
    var_9590721335395c43 = [];
    
    foreach ( func_array in self.spawn_functions )
    {
        if ( func_array[ "function" ] == function )
        {
            continue;
        }
        
        var_9590721335395c43[ var_9590721335395c43.size ] = func_array;
    }
    
    self.spawn_functions = var_9590721335395c43;
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x9a8e
// Size: 0x127
function add_spawn_function( function, param1, param2, param3, param4, param5 )
{
    assertex( !isalive( self ), "Tried to add_spawn_function to a living guy." );
    assertex( isspawner( self ), "Tried to add_spawn_function to something that isn't a spawner." );
    assertex( isdefined( self.spawn_functions ), "Tried to add_spawn_function before calling _load" );
    
    foreach ( func_array in self.spawn_functions )
    {
        if ( func_array[ "function" ] == function )
        {
            return;
        }
    }
    
    func = [];
    func[ "function" ] = function;
    func[ "param1" ] = param1;
    func[ "param2" ] = param2;
    func[ "param3" ] = param3;
    func[ "param4" ] = param4;
    func[ "param5" ] = param5;
    self.spawn_functions[ self.spawn_functions.size ] = func;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9bbd
// Size: 0x2d
function array_kill( array )
{
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] kill();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9bf2
// Size: 0x37
function ignore_triggers( timer )
{
    self endon( "death" );
    self.ignoretriggers = 1;
    
    if ( isdefined( timer ) )
    {
        wait timer;
    }
    else
    {
        wait 0.5;
    }
    
    self.ignoretriggers = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9c31
// Size: 0x29
function activate_trigger_with_targetname( msg )
{
    trigger = getent( msg, "targetname" );
    trigger activate_trigger();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9c62
// Size: 0x29
function activate_trigger_with_noteworthy( msg )
{
    trigger = getent( msg, "script_noteworthy" );
    trigger activate_trigger();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9c93
// Size: 0x29
function disable_trigger_with_targetname( msg )
{
    trigger = getent( msg, "targetname" );
    trigger trigger_off();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9cc4
// Size: 0x29
function disable_trigger_with_noteworthy( msg )
{
    trigger = getent( msg, "script_noteworthy" );
    trigger trigger_off();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9cf5
// Size: 0x29
function enable_trigger_with_targetname( msg )
{
    trigger = getent( msg, "targetname" );
    trigger trigger_on();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9d26
// Size: 0x29
function enable_trigger_with_noteworthy( msg )
{
    trigger = getent( msg, "script_noteworthy" );
    trigger trigger_on();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9d57
// Size: 0x4c
function set_team_pacifist( team, val )
{
    ai = getaiarray( team );
    
    for ( i = 0; i < ai.size ; i++ )
    {
        ai[ i ].pacifist = val;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x9dab
// Size: 0x9
function replace_on_death()
{
    scripts\sp\colors::colornode_replace_on_death();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9dbc
// Size: 0x1c
function spawn_reinforcement( classname, color )
{
    scripts\sp\colors::colornode_spawn_reinforcement( classname, color );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9de0
// Size: 0x60
function set_promotion_order( deadguy, replacer )
{
    if ( !isdefined( level.current_color_order ) )
    {
        level.current_color_order = [];
    }
    
    deadguy = shortencolor( deadguy );
    replacer = shortencolor( replacer );
    level.current_color_order[ deadguy ] = replacer;
    
    if ( !isdefined( level.current_color_order[ replacer ] ) )
    {
        set_empty_promotion_order( replacer );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x9e48
// Size: 0x33
function set_empty_promotion_order( deadguy )
{
    if ( !isdefined( level.current_color_order ) )
    {
        level.current_color_order = [];
    }
    
    level.current_color_order[ deadguy ] = "none";
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9e83
// Size: 0x72
function remove_color_from_array( array, color )
{
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        guy = array[ i ];
        
        if ( !isdefined( guy.script_forcecolor ) )
        {
            continue;
        }
        
        if ( guy.script_forcecolor == color )
        {
            continue;
        }
        
        newarray[ newarray.size ] = guy;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9efe
// Size: 0x72
function remove_noteworthy_from_array( array, noteworthy )
{
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        guy = array[ i ];
        
        if ( !isdefined( guy.script_noteworthy ) )
        {
            continue;
        }
        
        if ( guy.script_noteworthy == noteworthy )
        {
            continue;
        }
        
        newarray[ newarray.size ] = guy;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9f79
// Size: 0x5b
function get_closest_colored_friendly( color, origin )
{
    allies = get_force_color_guys( "allies", color );
    
    if ( !isdefined( origin ) )
    {
        friendly_origin = level.player.origin;
    }
    else
    {
        friendly_origin = origin;
    }
    
    return getclosest( friendly_origin, allies );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x9fdd
// Size: 0x5a
function remove_without_classname( array, classname )
{
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( !issubstr( array[ i ].classname, classname ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = array[ i ];
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa040
// Size: 0x5a
function remove_without_model( array, model )
{
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( !issubstr( array[ i ].model, model ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = array[ i ];
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xa0a3
// Size: 0x6d
function get_closest_colored_friendly_with_classname( color, classname, origin )
{
    allies = get_force_color_guys( "allies", color );
    
    if ( !isdefined( origin ) )
    {
        friendly_origin = level.player.origin;
    }
    else
    {
        friendly_origin = origin;
    }
    
    allies = remove_without_classname( allies, classname );
    return getclosest( friendly_origin, allies );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa119
// Size: 0x41
function promote_nearest_friendly( colorfrom, colorto )
{
    for ( ;; )
    {
        friendly = get_closest_colored_friendly( colorfrom );
        
        if ( !isalive( friendly ) )
        {
            wait 1;
            continue;
        }
        
        friendly set_force_color( colorto );
        return;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa162
// Size: 0x57
function instantly_promote_nearest_friendly( colorfrom, colorto )
{
    friendly = get_closest_colored_friendly( colorfrom );
    
    if ( !isalive( friendly ) )
    {
        assertex( 0, "Instant promotion from " + colorfrom + " to " + colorto + " failed!" );
        return;
    }
    
    friendly set_force_color( colorto );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xa1c5
// Size: 0x60
function instantly_promote_nearest_friendly_with_classname( colorfrom, colorto, classname )
{
    friendly = get_closest_colored_friendly_with_classname( colorfrom, classname );
    
    if ( !isalive( friendly ) )
    {
        assertex( 0, "Instant promotion from " + colorfrom + " to " + colorto + " failed!" );
        return;
    }
    
    friendly set_force_color( colorto );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xa231
// Size: 0x4a
function promote_nearest_friendly_with_classname( colorfrom, colorto, classname )
{
    for ( ;; )
    {
        friendly = get_closest_colored_friendly_with_classname( colorfrom, classname );
        
        if ( !isalive( friendly ) )
        {
            wait 1;
            continue;
        }
        
        friendly set_force_color( colorto );
        return;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xa283
// Size: 0x8b
function instantly_set_color_from_array_with_classname( array, color, classname )
{
    foundguy = 0;
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        guy = array[ i ];
        
        if ( foundguy || !issubstr( guy.classname, classname ) )
        {
            newarray[ newarray.size ] = guy;
            continue;
        }
        
        foundguy = 1;
        guy set_force_color( color );
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa317
// Size: 0x6d
function instantly_set_color_from_array( array, color )
{
    foundguy = 0;
    newarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        guy = array[ i ];
        
        if ( foundguy )
        {
            newarray[ newarray.size ] = guy;
            continue;
        }
        
        foundguy = 1;
        guy set_force_color( color );
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa38d
// Size: 0x18
function wait_for_script_noteworthy_trigger( msg )
{
    wait_for_trigger( msg, "script_noteworthy" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa3ad
// Size: 0x18
function wait_for_targetname_trigger( msg )
{
    wait_for_trigger( msg, "targetname" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa3cd
// Size: 0x23
function wait_for_flag_or_timeout( msg, timer )
{
    if ( flag( msg ) )
    {
        return;
    }
    
    level endon( msg );
    wait timer;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa3f8
// Size: 0x18
function wait_for_notify_or_timeout( msg, timer )
{
    self endon( msg );
    wait timer;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa418
// Size: 0x14
function wait_for_trigger_or_timeout( timer )
{
    self endon( "trigger" );
    wait timer;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xa434
// Size: 0x84
function wait_for_either_trigger( msg1, msg2 )
{
    ent = spawnstruct();
    array = [];
    array = array_combine( array, getentarray( msg1, "targetname" ) );
    array = array_combine( array, getentarray( msg2, "targetname" ) );
    
    for ( i = 0; i < array.size ; i++ )
    {
        ent thread ent_waits_for_trigger( array[ i ] );
    }
    
    ent waittill( "done" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa4c0
// Size: 0x29
function dronespawn_bodyonly( spawner )
{
    drone = scripts\sp\spawner::spawner_dronespawn( spawner );
    assert( isdefined( drone ) );
    return drone;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa4f2
// Size: 0xa9
function fakeactorspawn( spawner )
{
    if ( !isdefined( spawner ) )
    {
        spawner = self;
    }
    
    fakeactor = scripts\sp\spawner::spawner_dronespawn( spawner );
    assert( isdefined( fakeactor ) );
    fakeactor.spawn_funcs = spawner.spawn_functions;
    fakeactor.spawner = spawner;
    
    if ( isdefined( spawner.script_nodrop ) )
    {
        fakeactor.nodrop = spawner.script_nodrop;
    }
    
    if ( isdefined( spawner.script_noragdoll ) )
    {
        fakeactor.noragdoll = spawner.script_noragdoll;
    }
    
    fakeactor fakeactorspawn_setup();
    return fakeactor;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa5a4
// Size: 0x4e
function fakeactorspawn_setup( expendable )
{
    assertex( isdefined( level.fakeactor_spawn_func ), "level.fakeactor_spawn_func was not properly initialized." );
    self [[ level.fakeactor_spawn_func ]]( expendable );
    self.spawn_functions = undefined;
    thread scripts\sp\spawner::run_spawn_functions();
    self.script_fakeactor = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa5fa
// Size: 0x54
function bodyonlyspawn( spawner )
{
    bodyonly = scripts\sp\spawner::spawner_dronespawn( spawner );
    assert( isdefined( bodyonly ) );
    bodyonly.spawn_funcs = spawner.spawn_functions;
    bodyonly.spawn_functions = undefined;
    bodyonly thread scripts\sp\spawner::run_spawn_functions();
    return bodyonly;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xa657
// Size: 0x81
function dronespawn( spawner )
{
    if ( !isdefined( spawner ) )
    {
        spawner = self;
    }
    
    drone = scripts\sp\spawner::spawner_dronespawn( spawner );
    assert( isdefined( drone ) );
    assertex( isdefined( level.drone_spawn_func ), "You need to put scriptsspdrone_civilian::init(); OR scriptsspdrone_ai::init(); in your level script! Use the civilian version if your drone is a civilian and the _ai version if it's a friendly or enemy." );
    drone [[ level.drone_spawn_func ]]();
    drone.spawn_funcs = spawner.spawn_functions;
    drone.spawn_functions = undefined;
    drone thread scripts\sp\spawner::run_spawn_functions();
    return drone;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xa6e1
// Size: 0x75
function create_corpses()
{
    corpses = getentarray( "corpse", "script_noteworthy" );
    
    if ( corpses.size )
    {
        array_spawn_function( corpses, &init_corpse );
    }
    
    corpses = getentarray( "corpse_noragdoll", "script_noteworthy" );
    
    if ( corpses.size )
    {
        array_spawn_function( corpses, &init_corpse );
    }
    
    corpses = get_spawner_array( "corpse", "script_noteworthy" );
    
    if ( corpses.size )
    {
        array_spawn_function( corpses, &init_corpse );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xa75e
// Size: 0x237
function init_corpse()
{
    if ( !isdefined( self.script_animation ) )
    {
        assertmsg( "You must define a script_animation for a corpse to work!" );
        self delete();
        return;
    }
    
    self.animname = "corpse";
    self startusingheroonlylighting();
    
    if ( isai( self ) )
    {
        self.ignoreall = 1;
    }
    else
    {
        self notsolid();
    }
    
    if ( isdefined( self.target ) )
    {
        corpse_target = get_target_ent( self.target );
        self dontinterpolate();
        
        if ( isai( self ) )
        {
            self forceteleport( corpse_target.origin, corpse_target.angles );
        }
        else
        {
            self.origin = corpse_target.origin;
            self.angles = corpse_target.angles;
        }
    }
    
    weapon_model = getweaponmodel( self.weapon );
    
    if ( isdefined( weapon_model ) && weapon_model != "" )
    {
        if ( isai( self ) )
        {
            gun_remove();
        }
        
        if ( !isdefined( self.script_nodrop ) )
        {
            gun = spawn( "weapon_" + getcompleteweaponname( self.weapon ), self gettagorigin( "tag_weapon_right" ) );
            gun.angles = self gettagangles( "tag_weapon_right" );
        }
    }
    
    if ( isai( self ) )
    {
        if ( self.script_noteworthy == "corpse_noragdoll" )
        {
            self.noragdoll = 1;
        }
        
        set_deathanim( self.script_animation );
        self kill();
        return;
    }
    
    self animscripted( "corpse_anim", self.origin, self.angles, getanim( self.script_animation ), "deathplant", undefined, 0 );
    
    if ( self.script_noteworthy != "corpse_noragdoll" )
    {
        death_length = getanimlength( getanim( self.script_animation ) );
        
        if ( death_length > 0 )
        {
            wait death_length * 0.35;
        }
        
        if ( isdefined( self.fnpreragdoll ) )
        {
            self [[ self.fnpreragdoll ]]();
        }
        
        self startragdoll();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xa99d
// Size: 0x4f
function get_trigger_flag()
{
    if ( isdefined( self.script_flag ) )
    {
        return self.script_flag;
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        return self.script_noteworthy;
    }
    
    assertex( 0, "Flag trigger at " + self.origin + " has no script_flag set." );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xa9f4
// Size: 0x18
function set_default_pathenemy_settings()
{
    self.pathenemylookahead = 50;
    self.pathenemyfightdist = 192;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xaa14
// Size: 0xe2
function walk_and_talk( var_41e0c82e9f7aeb42, target, var_8e41959b7febe01 )
{
    if ( var_41e0c82e9f7aeb42 == "on" )
    {
        self._blackboard.walk_and_talk_requested = 1;
        
        if ( isdefined( var_8e41959b7febe01 ) )
        {
            if ( var_8e41959b7febe01 == "right" )
            {
                self.walk_and_talk_hemisphere = "right";
            }
            else
            {
                assert( var_8e41959b7febe01 == "left" );
                self.walk_and_talk_hemisphere = "left";
            }
        }
        
        if ( !isdefined( target ) )
        {
            self.walk_and_talk_target = level.player;
        }
        else
        {
            self.walk_and_talk_target = target;
            
            if ( !isdefined( target.origin ) )
            {
                assertmsg( "Target passed into ai_walk_and_talk does not have an origin!" );
            }
        }
        
        return;
    }
    
    assert( var_41e0c82e9f7aeb42 == "off" );
    self._blackboard.walk_and_talk_requested = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xaafe
// Size: 0x5c
function enable_eight_point_strafe( isenabled )
{
    if ( self.type == "dog" )
    {
        return;
    }
    
    if ( isenabled )
    {
        self._blackboard.eight_point_strafe_requested = 1;
        return;
    }
    
    assert( isenabled == 0 );
    self._blackboard.eight_point_strafe_requested = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xab62
// Size: 0xd
function enable_readystand()
{
    self.busereadyidle = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xab77
// Size: 0xc
function disable_readystand()
{
    self.busereadyidle = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xab8b
// Size: 0x44
function cqb_aim( the_target )
{
    if ( !isdefined( the_target ) )
    {
        self.var_6cd45c851740a435 = undefined;
        return;
    }
    
    self.var_6cd45c851740a435 = the_target;
    
    if ( !isdefined( the_target.origin ) )
    {
        assertmsg( "target passed into cqb_aim does not have an origin!" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xabd7
// Size: 0x61
function set_force_cover( val )
{
    assertex( !isdefined( val ) || val == 0 || val == 1, "invalid force cover set on guy" );
    assertex( isalive( self ), "Tried to set force cover on a dead guy" );
    
    if ( isdefined( val ) && val )
    {
        self.forcesuppression = 1;
        return;
    }
    
    self.forcesuppression = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xac40
// Size: 0x81, Type: bool
function first_touch( ent )
{
    if ( !isdefined( self.touched ) )
    {
        self.touched = [];
    }
    
    assertex( isdefined( ent ), "Ent is not defined!" );
    assertex( isdefined( ent.unique_id ), "Ent has no unique_id" );
    
    if ( isdefined( self.touched[ ent.unique_id ] ) )
    {
        return false;
    }
    
    self.touched[ ent.unique_id ] = 1;
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xacca
// Size: 0xc3
function add_hint_string( name, string, optionalfunc, altstate )
{
    if ( !isdefined( level.trigger_hint_string ) )
    {
        level.trigger_hint_string = [];
        level.trigger_hint_func = [];
        level.var_f8ab4524d06cd18f = [];
    }
    
    assertex( isdefined( name ), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint." );
    assertex( isdefined( string ), "Set a string for the hint string. This is the string you want to appear when the trigger is hit." );
    assertex( !isdefined( level.trigger_hint_string[ name ] ), "Tried to redefine hint " + name );
    level.trigger_hint_string[ name ] = string;
    precachestring( string );
    
    if ( isdefined( optionalfunc ) )
    {
        level.trigger_hint_func[ name ] = optionalfunc;
    }
    
    if ( isdefined( altstate ) )
    {
        level.var_f8ab4524d06cd18f[ name ] = altstate;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xad95
// Size: 0x26, Type: bool
function function_6c71a6be15e73611( name )
{
    if ( !isdefined( level.trigger_hint_string ) )
    {
        return false;
    }
    
    return isdefined( level.trigger_hint_string[ name ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xadc4
// Size: 0x2f
function function_3acd0c97287b3c28( name, string )
{
    if ( !isdefined( level.trigger_hint_string ) )
    {
        return 0;
    }
    
    level.trigger_hint_string[ name ] = string;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xadfb
// Size: 0x25
function clearthreatbias( group1, group2 )
{
    setthreatbias( group1, group2, 0 );
    setthreatbias( group2, group1, 0 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xae28
// Size: 0x15
function set_ignoresuppression( val )
{
    self.ignoresuppression = val;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xae45
// Size: 0x15
function set_goalradius( radius )
{
    self.goalradius = radius;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xae62
// Size: 0x15
function function_863020915099aafe( boolean )
{
    self.var_9a320501108844bd = boolean;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xae7f
// Size: 0x15
function set_allowdeath( val )
{
    self.allowdeath = val;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xae9c
// Size: 0x96
function set_run_anim( anime, alwaysrunforward )
{
    assertex( isdefined( anime ), "Tried to set run anim but didn't specify which animation to ues" );
    assertex( isdefined( self.animname ), "Tried to set run anim on a guy that had no anim name" );
    assertex( isdefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set run anim but the anim was not defined in the maps _anim file" );
    demeanor = "combat";
    set_move_anim( demeanor, anime );
    self.run_overrideanim = level.scr_anim[ self.animname ][ anime ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xaf3a
// Size: 0x81
function set_move_anim( demeanor, anime )
{
    assertex( isdefined( anime ), "Tried to set move anim but didn't specify which animation to ues" );
    assertex( isdefined( self.animname ), "Tried to set move anim on a guy that had no anim name" );
    assertex( isdefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set move anim but the anim was not defined in the maps _anim file" );
    asm_setdemeanoranimoverride( demeanor, "move", level.scr_anim[ self.animname ][ anime ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xafc3
// Size: 0x18
function clear_move_anim( demeanor )
{
    asm_cleardemeanoranimoverride( demeanor, "move" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xafe3
// Size: 0x81
function set_idle_anim( demeanor, anime )
{
    assertex( isdefined( anime ), "Tried to set idle anim but didn't specify which animation to ues" );
    assertex( isdefined( self.animname ), "Tried to set idle anim on a guy that had no anim name" );
    assertex( isdefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set idle anim but the anim was not defined in the maps _anim file" );
    asm_setdemeanoranimoverride( demeanor, "idle", level.scr_anim[ self.animname ][ anime ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb06c
// Size: 0x18
function clear_idle_anim( demeanor )
{
    asm_cleardemeanoranimoverride( demeanor, "idle" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb08c
// Size: 0x54
function set_dog_walk_anim()
{
    assertex( self.type == "dog" );
    self.a.movement = "walk";
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.script_nobark = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb0e8
// Size: 0x52
function set_arrival_speed( factor )
{
    if ( !isdefined( factor ) )
    {
        factor = 1;
    }
    
    if ( isdefined( self.asm.arrivalspeed ) )
    {
        self.asm.arrivalspeed = factor;
        return;
    }
    
    assertmsg( "Entity does not have an arrival speed defined in it's init" );
    return;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb142
// Size: 0x2f
function clear_arrival_speed()
{
    if ( isdefined( self.asm.arrivalspeed ) )
    {
        self.asm.arrivalspeed = 1;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb179
// Size: 0x5a
function override_move_with_purpose( demeanor )
{
    assert( isai( self ) );
    override_anim = asm_lookupanimfromalias( "move_walk_loop", "casual_purpose" );
    asm_setdemeanoranimoverride( demeanor, "move", override_anim );
    
    if ( demeanor == "casual" )
    {
        thread set_arrival_speed( 1.15 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb1db
// Size: 0x18
function clear_move_with_purpose()
{
    thread clear_move_anim( scripts\asm\asm::asm_getdemeanor() );
    thread clear_arrival_speed();
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 1
    // Checksum 0x0, Offset: 0xb1fb
    // Size: 0x19, Type: dev
    function set_generic_idle_anim( anime )
    {
        assertmsg( "this function is no longer supported.  please use set_idle_anim." );
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb21c
// Size: 0x14
function clear_generic_idle_anim()
{
    self.specialidleanim = undefined;
    self notify( "stop_specialidle" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xb238
// Size: 0x1d
function set_generic_run_anim( anime, alwaysrunforward )
{
    set_generic_run_anim_array( anime, undefined, alwaysrunforward );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb25d
// Size: 0x25
function clear_generic_run_anim()
{
    self notify( "movemode" );
    enable_turnanims();
    self.run_overrideanim = undefined;
    self.walk_overrideanim = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xb28a
// Size: 0x1a7
function set_generic_run_anim_array( anime, weights, alwaysrunforward )
{
    assertex( isdefined( anime ), "Tried to set generic run anim but didn't specify which animation to ues" );
    assertex( isdefined( level.scr_anim[ "generic" ][ anime ] ), "Tried to set generic run anim but the anim was not defined in the maps _anim file" );
    assertex( !isdefined( weights ) || isdefined( level.scr_anim[ "generic" ][ weights ] ), "weights needs to be a valid entry in level.scr_anim" );
    assertex( !isdefined( weights ) || isarray( level.scr_anim[ "generic" ][ weights ] ), "weights needs to be an array of animation weights (ascending order)" );
    assertex( isarray( level.scr_anim[ "generic" ][ anime ] ) || !isdefined( weights ), "its not valid to pass in a weights param and not an array of anims to run" );
    assertex( !isdefined( weights ) || level.scr_anim[ "generic" ][ weights ].size == level.scr_anim[ "generic" ][ anime ].size, "the weights array must equal the size of the anims array" );
    self notify( "movemode" );
    
    if ( !isdefined( alwaysrunforward ) || alwaysrunforward )
    {
        self.alwaysrunforward = 1;
    }
    else
    {
        self.alwaysrunforward = undefined;
    }
    
    disable_turnanims();
    self.run_overrideanim = level.scr_anim[ "generic" ][ anime ];
    self.walk_overrideanim = self.run_overrideanim;
    
    if ( isdefined( weights ) )
    {
        self.run_override_weights = level.scr_anim[ "generic" ][ weights ];
        self.walk_override_weights = self.run_override_weights;
        return;
    }
    
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xb439
// Size: 0x115
function set_run_anim_array( anime, weights, alwaysrunforward )
{
    assertex( isdefined( anime ), "Tried to set generic run anim but didn't specify which animation to ues" );
    assertex( isdefined( self.animname ), "Tried to set run anim on a guy that had no anim name" );
    assertex( isdefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set run anim but the anim was not defined in the maps _anim file" );
    self notify( "movemode" );
    
    if ( !isdefined( alwaysrunforward ) || alwaysrunforward )
    {
        self.alwaysrunforward = 1;
    }
    else
    {
        self.alwaysrunforward = undefined;
    }
    
    disable_turnanims();
    self.run_overrideanim = level.scr_anim[ self.animname ][ anime ];
    self.walk_overrideanim = self.run_overrideanim;
    
    if ( isdefined( weights ) )
    {
        self.run_override_weights = level.scr_anim[ self.animname ][ weights ];
        self.walk_override_weights = self.run_override_weights;
        return;
    }
    
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb556
// Size: 0x89
function clear_run_anim()
{
    self notify( "clear_run_anim" );
    self notify( "movemode" );
    
    if ( self.type == "dog" )
    {
        self.a.movement = "run";
        self.disablearrivals = 0;
        self.disableexits = 0;
        self.script_nobark = undefined;
        return;
    }
    
    demeanor = "combat";
    self.allowstrafe = 1;
    clear_move_anim( demeanor );
    self.run_overrideanim = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xb5e7
// Size: 0x154
function physicsjolt_proximity( outer_radius, inner_radius, force )
{
    self endon( "death" );
    self endon( "stop_physicsjolt" );
    
    if ( !isdefined( outer_radius ) || !isdefined( inner_radius ) || !isdefined( force ) )
    {
        outer_radius = 400;
        inner_radius = 256;
        force = ( 0, 0, 0.075 );
    }
    
    fade_distance = outer_radius * outer_radius;
    fade_speed = 3;
    base_force = force;
    
    while ( true )
    {
        wait 0.1;
        force = base_force;
        
        if ( self.code_classname == "script_vehicle" )
        {
            speed = self vehicle_getspeed();
            
            if ( speed < fade_speed )
            {
                scale = speed / fade_speed;
                force = base_force * scale;
            }
        }
        
        dist = distancesquared( self.origin, level.player.origin );
        scale = fade_distance / dist;
        
        if ( scale > 1 )
        {
            scale = 1;
        }
        
        force *= scale;
        total_force = force[ 0 ] + force[ 1 ] + force[ 2 ];
        
        if ( total_force > 0.025 )
        {
            physicsjitter( self.origin, outer_radius, inner_radius, force[ 2 ], force[ 2 ] * 2 );
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb743
// Size: 0x13
function set_goal_entity( ent )
{
    self setgoalentity( ent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xb75e
// Size: 0x65
function activate_trigger( name, type, triggeringent )
{
    if ( !isdefined( name ) )
    {
        activate_trigger_process( triggeringent );
        return;
    }
    
    trigs = getentarray( name, type );
    assertex( trigs.size, "No trigger(s) with kvp: " + type + ", " + name );
    array_thread( trigs, &activate_trigger_process, triggeringent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb7cb
// Size: 0x75
function activate_trigger_process( triggeringent )
{
    assertex( !isdefined( self.trigger_off ), "Tried to activate trigger that is OFF( either from trigger_off or from flags set on it through shift - G menu" );
    
    if ( isdefined( self.script_color_allies ) )
    {
        self.activated_color_trigger = 1;
        scripts\sp\colors::activate_color_trigger( "allies" );
    }
    
    if ( isdefined( self.script_color_axis ) )
    {
        self.activated_color_trigger = 1;
        scripts\sp\colors::activate_color_trigger( "axis" );
    }
    
    self notify( "trigger", triggeringent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb848
// Size: 0x9
function self_delete()
{
    self delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb859
// Size: 0x42, Type: bool
function has_color()
{
    if ( scripts\sp\colors::get_team() == "axis" )
    {
        return ( isdefined( self.script_color_axis ) || isdefined( self.script_forcecolor ) );
    }
    
    return isdefined( self.script_color_allies ) || isdefined( self.script_forcecolor );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb8a4
// Size: 0x1a
function clear_colors()
{
    clear_team_colors( "axis" );
    clear_team_colors( "allies" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xb8c6
// Size: 0x82
function clear_team_colors( team )
{
    level.currentcolorforced[ team ][ "r" ] = undefined;
    level.currentcolorforced[ team ][ "b" ] = undefined;
    level.currentcolorforced[ team ][ "c" ] = undefined;
    level.currentcolorforced[ team ][ "y" ] = undefined;
    level.currentcolorforced[ team ][ "p" ] = undefined;
    level.currentcolorforced[ team ][ "o" ] = undefined;
    level.currentcolorforced[ team ][ "g" ] = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xb950
// Size: 0x4d
function notify_delay( snotifystring, fdelay )
{
    assert( isdefined( self ) );
    assert( isdefined( snotifystring ) );
    assert( isdefined( fdelay ) );
    self endon( "death" );
    
    if ( fdelay > 0 )
    {
        wait fdelay;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( snotifystring );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xb9a5
// Size: 0x6d
function name_hide()
{
    assertex( isai( self ), "Calling on non AI" );
    
    if ( !isdefined( self.name ) )
    {
        return;
    }
    
    self.og_name = self.name;
    self.name = undefined;
    
    if ( isdefined( self.callsign ) )
    {
        self.og_callsign = self.callsign;
        self.callsign = "";
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xba1a
// Size: 0x5f
function name_show()
{
    assertex( isai( self ), "Calling on non AI" );
    assertex( isdefined( self.og_name ), "self.og_name is not defined, use name_hide() to first hide the name " );
    self.name = self.og_name;
    
    if ( isdefined( self.og_callsign ) )
    {
        self.callsign = self.og_callsign;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xba81
// Size: 0x4c
function place_weapon_on( objweapon, location )
{
    assert( isai( self ) );
    assert( isweapon( objweapon ) );
    
    if ( !aihasweapon( objweapon ) )
    {
        initweapon( objweapon );
    }
    
    scripts\anim\shared::placeweaponon( objweapon, location );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xbad5
// Size: 0x53
function player_moves( dist )
{
    org = level.player.origin;
    
    for ( ;; )
    {
        if ( distance( org, level.player.origin ) > dist )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xbb30
// Size: 0x51
function waittill_either_function( func1, parm1, func2, parm2 )
{
    ent = spawnstruct();
    thread waittill_either_function_internal( ent, func1, parm1 );
    thread waittill_either_function_internal( ent, func2, parm2 );
    ent waittill( "done" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xbb89
// Size: 0xf
function waittill_msg( msg )
{
    self waittill( msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbba0
// Size: 0x1c, Type: bool
function in_realism_mode()
{
    return isdefined( level.gameskill ) && level.gameskill == 4;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xbbc5
// Size: 0x64
function display_hint( hint, timeout, delay, endonentities, endonmessages )
{
    if ( in_realism_mode() || function_63171981a45b3ad8() )
    {
        return;
    }
    
    assertex( isdefined( level.trigger_hint_string ), "tried display_hint without add_trigger_hint" );
    thread display_hint_proc( hint, timeout, delay, endonentities, endonmessages );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xbc31
// Size: 0x50
function display_hint_forced( hint, timeout, delay, endonentities, endonmessages )
{
    assertex( isdefined( level.trigger_hint_string ), "tried display_hint without add_trigger_hint" );
    thread display_hint_proc( hint, timeout, delay, endonentities, endonmessages );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xbc89
// Size: 0x1b6
function display_hint_proc( hint, timeout, delay, endonentities, endonmessages )
{
    if ( isdefined( endonentities ) && isdefined( endonmessages ) )
    {
        if ( !isarray( endonentities ) )
        {
            endonentities = [ endonentities ];
        }
        
        if ( !isarray( endonmessages ) )
        {
            endonmessages = [ endonmessages ];
        }
        
        foreach ( entity in endonentities )
        {
            foreach ( message in endonmessages )
            {
                entity endon( message );
            }
        }
    }
    
    player = get_player_from_self();
    player endon( "new_hint" );
    
    if ( isdefined( level.trigger_hint_func[ hint ] ) )
    {
        player endon( "hint_function_cancel" );
        player childthread display_hint_function_cancel_logic( level.trigger_hint_func[ hint ] );
    }
    
    if ( istrue( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( level.trigger_hint_func[ hint ] ) )
    {
        if ( player [[ level.trigger_hint_func[ hint ] ]]() )
        {
            return;
        }
        
        player thread hintprint( level.trigger_hint_string[ hint ], level.trigger_hint_func[ hint ], timeout, undefined, level.var_f8ab4524d06cd18f[ hint ], endonentities, endonmessages );
        return;
    }
    
    player thread hintprint( level.trigger_hint_string[ hint ], undefined, timeout, undefined, level.var_f8ab4524d06cd18f[ hint ], endonentities, endonmessages );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xbe47
// Size: 0x22
function display_hint_function_cancel_logic( function )
{
    while ( true )
    {
        if ( [[ function ]]() )
        {
            self notify( "hint_function_cancel" );
        }
        
        waitframe();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xbe71
// Size: 0x44
function getgenericanim( anime )
{
    assertex( isdefined( level.scr_anim[ "generic" ][ anime ] ), "Generic anim " + anime + " was not defined in your _anim file." );
    return level.scr_anim[ "generic" ][ anime ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbebe
// Size: 0x21
function enable_careful()
{
    assertex( isai( self ), "Tried to make an ai careful but it wasn't called on an AI" );
    self.script_careful = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbee7
// Size: 0x28
function disable_careful()
{
    assertex( isai( self ), "Tried to unmake an ai careful but it wasn't called on an AI" );
    self.script_careful = 0;
    self notify( "stop_being_careful" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbf17
// Size: 0x2d
function enable_sprint()
{
    assertex( isai( self ), "Tried to make an ai sprint but it wasn't called on an AI" );
    self.sprint = 1;
    demeanor_override( "sprint" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbf4c
// Size: 0x27
function disable_sprint()
{
    assertex( isai( self ), "Tried to unmake an ai sprint but it wasn't called on an AI" );
    self.sprint = undefined;
    clear_demeanor_override();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbf7b
// Size: 0xd
function disable_bulletwhizbyreaction()
{
    self.disablebulletwhizbyreaction = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbf90
// Size: 0xc
function enable_bulletwhizbyreaction()
{
    self.disablebulletwhizbyreaction = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbfa4
// Size: 0xd
function set_fixednode_true()
{
    self.fixednode = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xbfb9
// Size: 0xc
function set_fixednode_false()
{
    self.fixednode = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0xbfcd
// Size: 0x9d
function spawn_aitype( aitype, origin, angles, forcespawn, perfectenemyinfo, var_75c15e716113c51b, targetname )
{
    if ( !isdefined( forcespawn ) )
    {
        forcespawn = 0;
    }
    
    if ( !isdefined( perfectenemyinfo ) )
    {
        perfectenemyinfo = 0;
    }
    
    if ( !isdefined( var_75c15e716113c51b ) )
    {
        var_75c15e716113c51b = 1;
    }
    
    spawned = dospawnaitype( aitype, origin, angles, forcespawn, perfectenemyinfo, var_75c15e716113c51b );
    
    if ( isalive( spawned ) )
    {
        if ( isdefined( targetname ) )
        {
            spawned.targetname = targetname;
        }
        
        spawned thread scripts\sp\spawner::spawn_think();
        
        if ( !spawn_failed( spawned ) )
        {
            return spawned;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xc073
// Size: 0x58f
function spawn_ai( forcespawn, magicbulletshield )
{
    if ( isdefined( self.script_delay_spawn ) )
    {
        self endon( "death" );
        wait self.script_delay_spawn;
    }
    
    spawnedguy = undefined;
    var_75c15e716113c51b = isdefined( self.script_stealthgroup ) && flag( "stealth_enabled" ) && !flag( "stealth_spotted" );
    var_7208fc96ea182f6 = 0;
    
    if ( isdefined( self.script_suspend ) )
    {
        var_7208fc96ea182f6 = scripts\sp\spawner::prespawn_suspended_ai();
        
        if ( self.count == 0 && !var_7208fc96ea182f6 )
        {
            return undefined;
        }
    }
    
    isaispawner = 0;
    forcedspawn = 0;
    
    if ( isdefined( self.script_drone ) )
    {
        spawned = dronespawn( self );
    }
    else if ( istrue( self.script_fakeactor ) )
    {
        spawned = fakeactorspawn( self );
    }
    else if ( isdefined( self.script_bodyonly ) )
    {
        spawned = bodyonlyspawn( self );
    }
    else
    {
        isaispawner = 1;
        
        if ( isdefined( self.script_forcespawn ) || istrue( forcespawn ) )
        {
            spawned = self stalingradspawn( var_75c15e716113c51b );
            forcedspawn = 1;
        }
        else if ( isdefined( self.script_forcespawndist ) && distancesquared( self.origin, level.player.origin ) > squared( self.script_forcespawndist ) )
        {
            spawned = self stalingradspawn( var_75c15e716113c51b );
            forcedspawn = 1;
        }
        else
        {
            spawned = self dospawn( var_75c15e716113c51b );
        }
    }
    
    if ( isaispawner )
    {
        if ( isdefined( magicbulletshield ) && magicbulletshield && isalive( spawned ) )
        {
            spawned magic_bullet_shield();
        }
        
        if ( spawn_failed( spawned ) )
        {
            assertex( !( var_7208fc96ea182f6 && isdefined( self.script_aigroup ) ), "Spawner @ " + self.origin + " cannot be suspended and have a .script_aigroup" );
            
            if ( !var_7208fc96ea182f6 && isdefined( self.script_aigroup ) )
            {
                scripts\sp\spawner::aigroup_decrement( level._ai_group[ self.script_aigroup ] );
            }
            
            if ( var_7208fc96ea182f6 )
            {
                self.count--;
                
                if ( !isdefined( self.try_og_origin ) )
                {
                    /#
                        if ( getunarchiveddebugdvar( @"hash_38a088b03f78dca1" ) == "<dev string:x275>" )
                        {
                            print3d( self.origin, "<dev string:x277>", ( 0.8, 0.8, 0.2 ), 1, 0.5, 200 );
                            line( level.player.origin, self.origin, ( 0.8, 0.8, 0.2 ), 1, 0, 200 );
                        }
                    #/
                    
                    self.try_og_origin = 1;
                    spawned = spawn_ai();
                    return spawned;
                }
                else
                {
                    self.try_og_origin = undefined;
                }
            }
            
            /#
                if ( getunarchiveddebugdvar( @"hash_38a088b03f78dca1" ) == "<dev string:x275>" )
                {
                    aiarray = getaispeciesarray( "<dev string:x299>", "<dev string:x299>" );
                    print3d( self.origin, "<dev string:x29d>" + aiarray.size + "<dev string:x2ac>", ( 0.8, 0.2, 0.2 ), 1, 0.8, 200 );
                    line( level.player.origin, self.origin, ( 0.8, 0.2, 0.2 ), 1, 0, 200 );
                }
            #/
        }
        else if ( forcedspawn )
        {
            /#
                if ( getunarchiveddebugdvar( @"hash_38a088b03f78dca1" ) == "<dev string:x275>" )
                {
                    origins = [ spawned.origin, spawned geteye(), ( spawned.origin + spawned geteye() ) / 2 ];
                    trace_passed = 0;
                    
                    foreach ( origin in origins )
                    {
                        trace_passed = sighttracepassed( level.player geteye(), origin, 0, [ level.player, spawned ], 0 );
                        
                        if ( trace_passed )
                        {
                            break;
                        }
                    }
                    
                    if ( trace_passed )
                    {
                        if ( isdefined( self.targetname ) )
                        {
                            println( "<dev string:x2b4>" + level.player geteye() + "<dev string:x2c7>" + self.targetname + "<dev string:x2e9>" + self.origin );
                        }
                        else if ( isdefined( self.script_noteworthy ) )
                        {
                            println( "<dev string:x2b4>" + level.player geteye() + "<dev string:x2ee>" + self.script_noteworthy + "<dev string:x2e9>" + self.origin );
                        }
                        else
                        {
                            println( "<dev string:x2b4>" + level.player geteye() + "<dev string:x317>" + self.origin );
                        }
                        
                        print3d( self.origin, "<dev string:x32c>", ( 0.8, 0.4, 0.2 ), 1, 0.8, 200 );
                        line( level.player.origin, self.origin, ( 0.8, 0.4, 0.2 ), 1, 0, 200 );
                    }
                }
            #/
        }
    }
    
    if ( isdefined( self.script_spawn_once ) )
    {
        self delete();
    }
    
    return spawned;
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xc60b
// Size: 0x5b
function function_stack( func, param1, param2, param3, param4, param5 )
{
    localentity = spawnstruct();
    localentity thread function_stack_proc( self, func, param1, param2, param3, param4, param5 );
    return function_stack_wait_finish( localentity );
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0xc66f
// Size: 0x98
function function_stack_timeout( timeout, func, param1, param2, param3, param4, param5 )
{
    localentity = spawnstruct();
    localentity thread function_stack_proc( self, func, param1, param2, param3, param4, param5 );
    
    if ( isdefined( localentity.function_stack_func_begun ) || localentity waittill_any_timeout( timeout, "function_stack_func_begun" ) != "timeout" )
    {
        return function_stack_wait_finish( localentity );
    }
    
    localentity notify( "death" );
    return 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xc70f
// Size: 0x7a
function function_stack_clear()
{
    newstack = [];
    
    if ( isdefined( self.function_stack[ 0 ] ) && isdefined( self.function_stack[ 0 ].function_stack_func_begun ) )
    {
        newstack[ 0 ] = self.function_stack[ 0 ];
    }
    
    self.function_stack = undefined;
    self notify( "clear_function_stack" );
    waittillframeend();
    
    if ( !newstack.size )
    {
        return;
    }
    
    if ( !newstack[ 0 ].function_stack_func_begun )
    {
        return;
    }
    
    self.function_stack = newstack;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xc791
// Size: 0x1b
function set_blur( magnitude, time )
{
    setblur( magnitude, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc7b4
// Size: 0x15
function set_goal_radius( radius )
{
    self.goalradius = radius;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc7d1
// Size: 0x15
function set_goal_height( height )
{
    self.goalheight = height;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc7ee
// Size: 0x31
function set_goal_node( node )
{
    self.last_set_goalnode = node;
    self.last_set_goalpos = undefined;
    self.last_set_goalent = undefined;
    self setgoalnode( node );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc827
// Size: 0x3f
function set_goal_node_targetname( targetname )
{
    assert( isdefined( targetname ) );
    node = getnode( targetname, "targetname" );
    assert( isdefined( node ) );
    set_goal_node( node );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc86e
// Size: 0x31
function set_goal_pos( origin )
{
    self.last_set_goalnode = undefined;
    self.last_set_goalpos = origin;
    self.last_set_goalent = undefined;
    self setgoalpos( origin );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xc8a7
// Size: 0x51
function set_goal_ent( target )
{
    set_goal_pos( target.origin );
    self.last_set_goalent = target;
    
    if ( isstruct( target ) && !isdefined( target.type ) )
    {
        target.type = "struct";
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xc900
// Size: 0x296
function get_spawner_array( name, key )
{
    all_spawners = getspawnerarray();
    spawner_array = [];
    
    if ( key == "code_classname" )
    {
        foreach ( spawner in all_spawners )
        {
            if ( isdefined( spawner.code_classname ) && spawner.code_classname == name )
            {
                spawner_array[ spawner_array.size ] = spawner;
            }
        }
    }
    else if ( key == "classname" )
    {
        foreach ( spawner in all_spawners )
        {
            if ( isdefined( spawner.classname ) && spawner.classname == name )
            {
                spawner_array[ spawner_array.size ] = spawner;
            }
        }
    }
    else if ( key == "target" )
    {
        foreach ( spawner in all_spawners )
        {
            if ( isdefined( spawner.target ) && spawner.target == name )
            {
                spawner_array[ spawner_array.size ] = spawner;
            }
        }
    }
    else if ( key == "script_linkname" )
    {
        foreach ( spawner in all_spawners )
        {
            if ( isdefined( spawner.script_linkname ) && spawner.script_linkname == name )
            {
                spawner_array[ spawner_array.size ] = spawner;
            }
        }
    }
    else if ( key == "script_noteworthy" )
    {
        foreach ( spawner in all_spawners )
        {
            if ( isdefined( spawner.script_noteworthy ) && spawner.script_noteworthy == name )
            {
                spawner_array[ spawner_array.size ] = spawner;
            }
        }
    }
    else if ( key == "targetname" )
    {
        assertmsg( "You are using targetname, use the code call GetSpawnerArray() instead of this script call" );
    }
    else
    {
        assertmsg( "key '%s' does not internally belong to entities", key );
    }
    
    return spawner_array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xcb9f
// Size: 0x1a5
function array_spawn( spawners, bforcespawn, var_bcbfa4748fd0f1ea, var_9147e88682bab404 )
{
    if ( !isdefined( var_bcbfa4748fd0f1ea ) )
    {
        var_bcbfa4748fd0f1ea = 0;
    }
    
    guys = [];
    
    foreach ( spawner in spawners )
    {
        spawner.count = 1;
        
        if ( getsubstr( spawner.classname, 7, 10 ) == "veh" )
        {
            guy = spawner spawn_vehicle();
            
            /#
                if ( isdefined( spawner.export ) )
                {
                    assertex( isalive( guy ), "<dev string:x341>" + spawner.export + "<dev string:x356>" );
                }
                else
                {
                    assertex( isalive( guy ), "<dev string:x368>" + spawner.origin + "<dev string:x356>" );
                }
            #/
            
            if ( isdefined( guy.target ) && !isdefined( guy.script_moveoverride ) )
            {
                guy thread scripts\common\vehicle_paths::gopath();
            }
            
            guys[ guys.size ] = guy;
        }
        else
        {
            guy = spawner spawn_ai( bforcespawn );
            
            if ( !var_bcbfa4748fd0f1ea )
            {
                assertex( isalive( guy ), "Guy with export " + spawner.export + " failed to spawn." );
            }
            
            guys[ guys.size ] = guy;
        }
        
        if ( istrue( var_9147e88682bab404 ) )
        {
            waitframe();
        }
    }
    
    if ( !var_bcbfa4748fd0f1ea )
    {
        assertex( guys.size == spawners.size, "Didnt spawn correct number of guys" );
    }
    
    return guys;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xcd4d
// Size: 0x72
function array_spawn_targetname( targetname, forcespawn, var_bcbfa4748fd0f1ea, var_fb4c22ca40a3c27e, var_9147e88682bab404 )
{
    spawners = getspawnerarray( targetname );
    spawners = array_merge( spawners, getentarray( targetname, "targetname" ) );
    assertex( spawners.size, "Tried to spawn spawners with targetname " + targetname + " but there are no spawners" );
    return array_spawn( spawners, forcespawn, var_bcbfa4748fd0f1ea, var_9147e88682bab404 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xcdc8
// Size: 0x6f
function array_spawn_noteworthy( noteworthy, forcespawn, var_bcbfa4748fd0f1ea, var_fb4c22ca40a3c27e )
{
    spawners = get_spawner_array( noteworthy, "script_noteworthy" );
    spawners = array_merge( spawners, getentarray( noteworthy, "script_noteworthy" ) );
    assertex( spawners.size, "Tried to spawn spawners with script_noteworthy " + noteworthy + " but there are no spawners" );
    return array_spawn( spawners, forcespawn, var_bcbfa4748fd0f1ea );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xce40
// Size: 0x55
function spawn_script_noteworthy( script_noteworthy, bforcespawn )
{
    spawner = getspawner( script_noteworthy, "script_noteworthy" );
    assertex( isdefined( spawner ), "Spawner with script_noteworthy " + script_noteworthy + " does not exist." );
    guy = spawner spawn_ai( bforcespawn );
    return guy;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xce9e
// Size: 0x55
function spawn_targetname( targetname, bforcespawn )
{
    spawner = getspawner( targetname, "targetname" );
    assertex( isdefined( spawner ), "Spawner with targetname " + targetname + " does not exist." );
    guy = spawner spawn_ai( bforcespawn );
    return guy;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xcefc
// Size: 0x15
function set_grenadeammo( count )
{
    self.grenadeammo = count;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xcf19
// Size: 0x8d
function get_player_feet_from_view()
{
    assert( isplayer( self ) );
    tagorigin = self.origin;
    upvec = anglestoup( self getplayerangles() );
    height = self getplayerviewheight();
    player_eye = tagorigin + ( 0, 0, height );
    var_b3c795f07908b2ea = tagorigin + upvec * height;
    diff_vec = player_eye - var_b3c795f07908b2ea;
    fake_origin = tagorigin + diff_vec;
    return fake_origin;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xcfaf
// Size: 0x15
function set_baseaccuracy( val )
{
    self.baseaccuracy = val;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xcfcc
// Size: 0xb
function get_baseaccuracy()
{
    return self.baseaccuracy;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xcfe0
// Size: 0x33
function set_attackeraccuracy( val )
{
    if ( issp() && isplayer( self ) )
    {
        scripts\sp\utility::set_player_attacker_accuracy( val );
        return;
    }
    
    self.attackeraccuracy = val;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd01b
// Size: 0x12
function autosave_now( suppress_print )
{
    return scripts\sp\autosave::_autosave_game_now( suppress_print );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd036
// Size: 0xa
function autosave_now_silent()
{
    return scripts\sp\autosave::_autosave_game_now( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd049
// Size: 0x26
function set_generic_deathanim( deathanim )
{
    self.deathanim = getgenericanim( deathanim );
    self.isdeathanimdefined = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd077
// Size: 0x15
function set_dontmelee( bool )
{
    self.dontmelee = bool;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd094
// Size: 0x25
function putgunaway()
{
    scripts\anim\shared::placeweaponon( self.weapon, "none" );
    self.weapon = nullweapon();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd0c1
// Size: 0x19
function anim_stopanimscripted()
{
    self stopanimscripted();
    self notify( "stop_loop" );
    self notify( "stop_animmode" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd0e2
// Size: 0x29
function antigrav_float_ai_override( bool )
{
    assertex( isai( self ), "Tried to override antigrav floating on a non ai" );
    self.allowantigrav = bool;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd113
// Size: 0x20
function antigrav_clear_float_ai_override()
{
    assertex( isai( self ), "Tried to clear override antigrav floating on a non ai" );
    self.allowantigrav = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xd13b
// Size: 0x1f0
function antigrav_disable_nav_obstacle_for_team( team, bool )
{
    assertex( isdefined( level.antigrav ), "Called antigrav_disable_nav_obstacle_for_teams before antigrav grenades were initialized!" );
    
    if ( bool )
    {
        if ( !isdefined( level.antigrav.disablenavobstacleteams ) || level.antigrav.disablenavobstacleteams.size == 0 || team == "all" )
        {
            level.antigrav.disablenavobstacleteams = [];
            level.antigrav.disablenavobstacleteams[ 0 ] = team;
        }
        else if ( level.antigrav.disablenavobstacleteams[ 0 ] != "all" )
        {
            level.antigrav.disablenavobstacleteams = array_combine_unique( level.antigrav.disablenavobstacleteams, [ team ] );
        }
        
        return;
    }
    
    if ( !isdefined( level.antigrav.disablenavobstacleteams ) || level.antigrav.disablenavobstacleteams.size == 0 )
    {
        return;
    }
    
    if ( team == "all" )
    {
        level.antigrav.disablenavobstacleteams = undefined;
        return;
    }
    
    if ( level.antigrav.disablenavobstacleteams[ 0 ] == "all" )
    {
        level.antigrav.disablenavobstacleteams = [];
        
        if ( team == "allies" )
        {
            level.antigrav.disablenavobstacleteams[ 0 ] = "axis";
        }
        else
        {
            level.antigrav.disablenavobstacleteams[ 0 ] = "allies";
        }
        
        return;
    }
    
    level.antigrav.disablenavobstacleteams = array_remove_array( level.antigrav.disablenavobstacleteams, [ team ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd333
// Size: 0x13, Type: bool
function kill_wrapper()
{
    self enabledeathshield( 0 );
    self kill();
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xd34f
// Size: 0x9c
function array_wait_match( array, match, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_wait_match_proc( notifystruct, element, match, message );
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        notifystruct waittill( "array_wait_match_proc" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xd3f3
// Size: 0x39
function array_wait_match_proc( notifystruct, element, match, message )
{
    notifystruct endon( "array_wait_success" );
    element waittillmatch( match, message );
    notifystruct notify( "array_wait_match_proc" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xd434
// Size: 0x81
function array_any_wait_match( array, match, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_any_wait_match_proc( notifystruct, element, match, message );
    }
    
    notifystruct waittill( "array_wait_proc" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xd4bd
// Size: 0x32
function array_any_wait_match_proc( notifystruct, element, match, message )
{
    element waittillmatch( match, message );
    notifystruct notify( "array_wait_proc" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd4f7
// Size: 0x16
function die()
{
    self kill( ( 0, 0, 0 ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd515
// Size: 0x40
function getmodel( str )
{
    assertex( isdefined( level.scr_model[ str ] ), "Tried to getmodel on model " + str + " but level.scr_model[ " + str + " was not defined." );
    return level.scr_model[ str ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd55e
// Size: 0x1d, Type: bool
function isads()
{
    assert( isplayer( self ) );
    return self playerads() > 0.5;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xd584
// Size: 0x14
function disable_replace_on_death()
{
    self.replace_on_death = undefined;
    self notify( "_disable_reinforcement" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xd5a0
// Size: 0x111
function waittill_player_lookat( dot, timer, dot_only, timeout, ignore_ent, player )
{
    if ( !isdefined( player ) )
    {
        player = level.player;
    }
    
    timeoutent = spawnstruct();
    
    if ( isdefined( timeout ) )
    {
        timeoutent thread notify_delay( "timeout", timeout );
    }
    
    timeoutent endon( "timeout" );
    
    if ( !isdefined( dot ) )
    {
        dot = 0.92;
    }
    
    if ( !isdefined( timer ) )
    {
        timer = 0;
    }
    
    base_time = int( timer * 20 );
    count = base_time;
    self endon( "death" );
    ai_guy = isai( self );
    org = undefined;
    
    for ( ;; )
    {
        if ( ai_guy )
        {
            org = self geteye();
        }
        else
        {
            org = self.origin;
        }
        
        if ( player player_looking_at( org, dot, dot_only, ignore_ent ) )
        {
            count--;
            
            if ( count <= 0 )
            {
                return 1;
            }
        }
        else
        {
            count = base_time;
        }
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xd6b9
// Size: 0x3f
function waittill_player_lookat_for_time( timer, dot, dot_only, ignore_ent )
{
    assertex( isdefined( timer ), "Tried to do waittill_player_lookat_for_time with no time parm." );
    waittill_player_lookat( dot, timer, dot_only, undefined, ignore_ent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xd700
// Size: 0xe2
function player_looking_at( start, dot, dot_only, ignore_ent )
{
    if ( !isdefined( dot ) )
    {
        dot = 0.8;
    }
    
    player = get_player_from_self();
    end = player geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    if ( isdefined( dot_only ) )
    {
        assertex( dot_only, "dot_only must be true or undefined" );
        return 1;
    }
    
    return ray_trace_detail_passed( start, end, ignore_ent, create_default_contents( 1 ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xd7eb
// Size: 0x60, Type: bool
function either_player_looking_at( org, dot, dot_only, ignore_ent )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] player_looking_at( org, dot, dot_only, ignore_ent ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xd854
// Size: 0x92
function point_orientation_relative_to_player( point )
{
    player = get_player_from_self();
    angles = vectortoangles( point - player geteye() );
    forward = anglestoforward( angles );
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    cross = vectorcross( forward, player_forward );
    
    if ( cross[ 2 ] < 0 )
    {
        return "left";
    }
    
    return "right";
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xd8ee
// Size: 0x66, Type: bool
function players_within_distance( fdist, org )
{
    fdistsquared = fdist * fdist;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( distancesquared( org, level.players[ i ].origin ) < fdistsquared )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xd95d
// Size: 0xdd
function ai_delete_when_out_of_sight( ai_array, fdist )
{
    if ( !isdefined( ai_array ) )
    {
        return;
    }
    
    var_7e36d51c34f3bf2f = 0.75;
    
    while ( ai_array.size > 0 )
    {
        wait 1;
        
        for ( i = 0; i < ai_array.size ; i++ )
        {
            if ( !isalive( ai_array[ i ] ) )
            {
                ai_array = array_remove( ai_array, ai_array[ i ] );
                continue;
            }
            
            if ( players_within_distance( fdist, ai_array[ i ].origin ) )
            {
                continue;
            }
            
            if ( either_player_looking_at( ai_array[ i ].origin + ( 0, 0, 48 ), var_7e36d51c34f3bf2f, 1 ) )
            {
                continue;
            }
            
            if ( isdefined( ai_array[ i ].magic_bullet_shield ) )
            {
                ai_array[ i ] stop_magic_bullet_shield();
            }
            
            ai_array[ i ] delete();
            ai_array = array_remove( ai_array, ai_array[ i ] );
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xda42
// Size: 0x14e
function add_wait( func, parm1, parm2, parm3, parm4 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    if ( isdefined( parm4 ) )
    {
        ent.parms[ ent.parms.size ] = parm4;
    }
    
    if ( !isdefined( level.waits.wait_any_func_array ) )
    {
        level.waits.wait_any_func_array = [ ent ];
        return;
    }
    
    level.waits.wait_any_func_array[ level.waits.wait_any_func_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xdb98
// Size: 0xf3
function add_abort( func, parm1, parm2, parm3 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    level.waits.abort_wait_any_func_array[ level.waits.abort_wait_any_func_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xdc93
// Size: 0x142
function add_func( func, parm1, parm2, parm3, parm4, var_77895a5b8a625552 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    if ( isdefined( parm4 ) )
    {
        ent.parms[ ent.parms.size ] = parm4;
    }
    
    if ( isdefined( var_77895a5b8a625552 ) )
    {
        ent.parms[ ent.parms.size ] = var_77895a5b8a625552;
    }
    
    level.waits.run_func_after_wait_array[ level.waits.run_func_after_wait_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xdddd
// Size: 0x142
function add_call( func, parm1, parm2, parm3, parm4, var_77895a5b8a625552 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    if ( isdefined( parm4 ) )
    {
        ent.parms[ ent.parms.size ] = parm4;
    }
    
    if ( isdefined( var_77895a5b8a625552 ) )
    {
        ent.parms[ ent.parms.size ] = var_77895a5b8a625552;
    }
    
    level.waits.run_call_after_wait_array[ level.waits.run_call_after_wait_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xdf27
// Size: 0x135
function add_noself_call( func, parm1, parm2, parm3, parm4, var_77895a5b8a625552 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    if ( isdefined( parm4 ) )
    {
        ent.parms[ ent.parms.size ] = parm4;
    }
    
    if ( isdefined( var_77895a5b8a625552 ) )
    {
        ent.parms[ ent.parms.size ] = var_77895a5b8a625552;
    }
    
    level.waits.run_noself_call_after_wait_array[ level.waits.run_noself_call_after_wait_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xe064
// Size: 0x71
function add_endon( name )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.ender = name;
    level.waits.do_wait_endons_array[ level.waits.do_wait_endons_array.size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe0dd
// Size: 0x6d
function do_wait_any()
{
    init_waits();
    assertex( isdefined( level.waits.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
    assertex( level.waits.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first" );
    do_wait( level.waits.wait_any_func_array.size - 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xe152
// Size: 0x20c
function do_wait( var_ff009ed2debc01c4 )
{
    init_waits();
    
    if ( !isdefined( var_ff009ed2debc01c4 ) )
    {
        var_ff009ed2debc01c4 = 0;
    }
    
    /#
        level notify( "<dev string:x374>" );
    #/
    
    assertex( isdefined( level.waits.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
    ent = spawnstruct();
    array = level.waits.wait_any_func_array;
    endons = level.waits.do_wait_endons_array;
    after_array = level.waits.run_func_after_wait_array;
    call_array = level.waits.run_call_after_wait_array;
    var_953b218366c91a88 = level.waits.run_noself_call_after_wait_array;
    abort_array = level.waits.abort_wait_any_func_array;
    level.waits.wait_any_func_array = [];
    level.waits.run_func_after_wait_array = [];
    level.waits.do_wait_endons_array = [];
    level.waits.abort_wait_any_func_array = [];
    level.waits.run_call_after_wait_array = [];
    level.waits.run_noself_call_after_wait_array = [];
    ent.count = array.size;
    ent array_levelthread( array, &waittill_func_ends, endons );
    ent thread do_abort( abort_array );
    ent endon( "any_funcs_aborted" );
    
    for ( ;; )
    {
        if ( ent.count <= var_ff009ed2debc01c4 )
        {
            break;
        }
        
        ent waittill( "func_ended" );
    }
    
    ent notify( "all_funcs_ended" );
    array_levelthread( after_array, &exec_func, [] );
    array_levelthread( call_array, &exec_call );
    array_levelthread( var_953b218366c91a88, &exec_call_noself );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe366
// Size: 0x174
function do_funcs()
{
    /#
        level notify( "<dev string:x374>" );
    #/
    
    assertex( isdefined( level.waits.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
    ent = spawnstruct();
    assertex( !level.waits.wait_any_func_array.size, "Don't use add_wait and do_funcs together." );
    assertex( !level.waits.do_wait_endons_array.size, "Don't use add_endon and do_funcs together." );
    assertex( !level.waits.run_call_after_wait_array.size, "Don't use add_call and do_funcs together." );
    assertex( !level.waits.run_noself_call_after_wait_array.size, "Don't use add_call and do_funcs together." );
    assertex( !level.waits.abort_wait_any_func_array.size, "Do_funcs doesn't support add_abort." );
    after_array = level.waits.run_func_after_wait_array;
    level.waits.run_func_after_wait_array = [];
    
    foreach ( func_struct in after_array )
    {
        level exec_func( func_struct, [] );
    }
    
    ent notify( "all_funcs_ended" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe4e2
// Size: 0xa5, Type: bool
function is_default_start()
{
    if ( isdefined( level.forced_start_catchup ) && level.forced_start_catchup == 1 )
    {
        return false;
    }
    
    if ( isdefined( level.default_start_override_alt ) && level.default_start_override_alt == level.start_point )
    {
        return true;
    }
    
    if ( isdefined( level.default_start_override ) )
    {
        if ( level.default_start_override == level.start_point )
        {
            return true;
        }
    }
    else if ( level_has_start_points() )
    {
        return ( level.start_point == level.start_functions[ 0 ][ "name" ] );
    }
    
    return level.start_point == "default";
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xe590
// Size: 0x68
function manual_linkto( entity, offset )
{
    entity endon( "death" );
    self endon( "death" );
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    for ( ;; )
    {
        self.origin = entity.origin + offset;
        self.angles = entity.angles;
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe600
// Size: 0x9
function nextmission()
{
    scripts\sp\endmission::nextmission_internal();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xe611
// Size: 0x4e
function nextmission_preload( type, var_740cf07d74dba935 )
{
    if ( !flag_exist( "nextmission_preload_complete" ) )
    {
        flag_init( "nextmission_preload_complete" );
    }
    
    flag_clear( "nextmission_preload_complete" );
    scripts\sp\endmission::nextmission_preload_internal( type, var_740cf07d74dba935 );
    flag_set( "nextmission_preload_complete" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe667
// Size: 0x9
function nextmission_primeloadbink()
{
    scripts\sp\endmission::nextmission_primeloadbink_internal();
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0xe678
// Size: 0x7a
function make_array( index1, index2, index3, index4, index5 )
{
    assertex( isdefined( index1 ), "Need to define index 1 at least" );
    array = [];
    array[ array.size ] = index1;
    
    if ( isdefined( index2 ) )
    {
        array[ array.size ] = index2;
    }
    
    if ( isdefined( index3 ) )
    {
        array[ array.size ] = index3;
    }
    
    if ( isdefined( index4 ) )
    {
        array[ array.size ] = index4;
    }
    
    if ( isdefined( index5 ) )
    {
        array[ array.size ] = index5;
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe6fb
// Size: 0xd
function fail_on_friendly_fire()
{
    level.failonfriendlyfire = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe710
// Size: 0xc
function normal_friendly_fire_penalty()
{
    level.failonfriendlyfire = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xe724
// Size: 0x78
function getplayerclaymores()
{
    assert( isplayer( self ) );
    claymorecount = 0;
    heldweapons = self.equippedweapons;
    
    for ( i = 0; i < heldweapons.size ; i++ )
    {
        weapon = heldweapons[ i ];
        
        if ( weapon.basename == "claymore" )
        {
            claymorecount += self getweaponammoclip( weapon );
        }
    }
    
    return claymorecount;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xe7a5
// Size: 0xb6
function lerp_saveddvar( name, value, time )
{
    curr = getdvarfloat( name );
    level notify( getxhashhexname( name ) + "_lerp_savedDvar" );
    level endon( getxhashhexname( name ) + "_lerp_savedDvar" );
    range = value - curr;
    interval = 0.05;
    count = int( time / interval );
    
    if ( count > 0 )
    {
        delta = range / count;
        
        while ( count )
        {
            curr += delta;
            setsaveddvar( name, curr );
            wait interval;
            count--;
        }
    }
    
    setsaveddvar( name, value );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xe863
// Size: 0xfd
function lerp_omnvar( name, value, time, round_float )
{
    curr = getomnvar( name );
    level notify( getxhashhexname( name ) + "_lerp_savedDvar" );
    level endon( getxhashhexname( name ) + "_lerp_savedDvar" );
    range = value - curr;
    interval = 0.05;
    count = int( time / interval );
    delta = range / count;
    
    while ( count )
    {
        curr += delta;
        
        if ( isdefined( round_float ) )
        {
            round = math::round_float( curr, round_float );
            setomnvar( name, round );
        }
        else
        {
            setomnvar( name, curr );
        }
        
        wait interval;
        count--;
    }
    
    if ( isdefined( round_float ) )
    {
        round = math::round_float( value, round_float );
        setomnvar( name, round );
        return;
    }
    
    setomnvar( name, value );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xe968
// Size: 0xba
function lerp_omnvarint( name, value, time )
{
    curr = getomnvar( name );
    level notify( getxhashhexname( name ) + "_lerp_savedDvar" );
    level endon( getxhashhexname( name ) + "_lerp_savedDvar" );
    range = value - curr;
    interval = 0.05;
    count = int( time / interval );
    delta = range / count;
    
    while ( count )
    {
        curr += delta;
        setomnvar( name, int( curr ) );
        wait interval;
        count--;
    }
    
    setomnvar( name, int( value ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xea2a
// Size: 0x20
function slowmo_setspeed_slow( speed )
{
    level.slowmo.speed_slow = speed;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xea52
// Size: 0x20
function slowmo_setspeed_norm( speed )
{
    level.slowmo.speed_norm = speed;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xea7a
// Size: 0x20
function slowmo_setlerptime_in( time )
{
    level.slowmo.lerp_time_in = time;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xeaa2
// Size: 0x20
function slowmo_setlerptime_out( time )
{
    level.slowmo.lerp_time_out = time;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xeaca
// Size: 0x56
function slowmo_lerp_in()
{
    if ( istrue( level.no_slowmo ) )
    {
        return;
    }
    
    scripts\sp\audio::set_slowmo_dialogue_start();
    setslowmotion( level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xeb28
// Size: 0x56
function slowmo_lerp_out()
{
    if ( istrue( level.no_slowmo ) )
    {
        return;
    }
    
    setslowmotion( level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out );
    scripts\sp\audio::set_slowmo_dialogue_end();
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0xeb86
// Size: 0x5c
function add_earthquake( name, mag, duration, radius )
{
    level.earthquake[ name ][ "magnitude" ] = mag;
    level.earthquake[ name ][ "duration" ] = duration;
    level.earthquake[ name ][ "radius" ] = radius;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xebea
// Size: 0x7d
function get_average_origin( array )
{
    origin = ( 0, 0, 0 );
    
    foreach ( member in array )
    {
        origin += member.origin;
    }
    
    return origin * 1 / array.size;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xec70
// Size: 0x7d
function function_874b64f0417c4374( array )
{
    angles = ( 0, 0, 0 );
    
    foreach ( member in array )
    {
        angles += member.angles;
    }
    
    return angles * 1 / array.size;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xecf6
// Size: 0xff
function generic_damage_think()
{
    if ( !isdefined( self.damage_functions ) )
    {
        self.damage_functions = [];
    }
    
    self endon( "entitydeleted" );
    self endon( "stop_generic_damage_think" );
    
    for ( ;; )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        foreach ( func in self.damage_functions )
        {
            thread [[ func ]]( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xedfd
// Size: 0x21
function add_damage_function( func )
{
    self.damage_functions[ self.damage_functions.size ] = func;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xee26
// Size: 0x79
function remove_damage_function( damage_func )
{
    new_array = [];
    
    foreach ( func in self.damage_functions )
    {
        if ( func == damage_func )
        {
            continue;
        }
        
        new_array[ new_array.size ] = func;
    }
    
    self.damage_functions = new_array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xeea7
// Size: 0x1e
function playlocalsoundwrapper( alias )
{
    assert( isdefined( alias ) );
    self playlocalsound( alias );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xeecd
// Size: 0x4e
function teleport_player( object )
{
    level.player setorigin( object.origin );
    
    if ( isdefined( object.angles ) )
    {
        level.player setplayerangles( object.angles );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0xef23
// Size: 0x60
function translate_local()
{
    entities = [];
    
    if ( isdefined( self.entities ) )
    {
        entities = self.entities;
    }
    
    if ( isdefined( self.entity ) )
    {
        entities[ entities.size ] = self.entity;
    }
    
    assertex( entities.size > 0, "Tried to do translate_local without any entities" );
    array_levelthread( entities, &translate_local_on_ent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0xef8b
// Size: 0x66
function open_up_fov( time, player_rig, tag, arcright, arcleft, arctop, arcbottom )
{
    level.player endon( "stop_opening_fov" );
    wait time;
    level.player playerlinktodelta( player_rig, tag, 1, arcright, arcleft, arctop, arcbottom, 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xeff9
// Size: 0xbb
function get_ai_touching_volume( steam, species, var_4e6d7bb6844ad4ec )
{
    if ( !isdefined( steam ) )
    {
        steam = "all";
    }
    
    if ( !isdefined( species ) )
    {
        species = "all";
    }
    
    ateam = getaispeciesarray( steam, species );
    var_3ecbf1096d1ba823 = [];
    
    foreach ( guy in ateam )
    {
        assertex( isalive( guy ), "Got ai array yet got a dead guy!" );
        
        if ( guy istouching( self ) )
        {
            var_3ecbf1096d1ba823[ var_3ecbf1096d1ba823.size ] = guy;
        }
    }
    
    return var_3ecbf1096d1ba823;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xf0bd
// Size: 0x109
function get_drones_touching_volume( steam )
{
    if ( !isdefined( steam ) )
    {
        steam = "all";
    }
    
    adrones = [];
    
    if ( steam == "all" )
    {
        adrones = array_merge( level.drones[ "allies" ].array, level.drones[ "axis" ].array );
        adrones = array_merge( adrones, level.drones[ "neutral" ].array );
    }
    else
    {
        adrones = level.drones[ steam ].array;
    }
    
    var_eb117856ce650a18 = [];
    
    foreach ( drone in adrones )
    {
        if ( !isdefined( drone ) )
        {
            continue;
        }
        
        if ( drone istouching( self ) )
        {
            var_eb117856ce650a18[ var_eb117856ce650a18.size ] = drone;
        }
    }
    
    return var_eb117856ce650a18;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xf1cf
// Size: 0xec
function get_drones_with_targetname( stargetname )
{
    adrones = array_merge( level.drones[ "allies" ].array, level.drones[ "axis" ].array );
    adrones = array_merge( adrones, level.drones[ "neutral" ].array );
    var_eb117856ce650a18 = [];
    
    foreach ( drone in adrones )
    {
        if ( !isdefined( drone ) )
        {
            continue;
        }
        
        if ( isdefined( drone.targetname ) && drone.targetname == stargetname )
        {
            var_eb117856ce650a18[ var_eb117856ce650a18.size ] = drone;
        }
    }
    
    return var_eb117856ce650a18;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xf2c4
// Size: 0x3d
function set_count( count )
{
    /#
        assertex( isdefined( self ), "<dev string:x38b>" );
        assertex( !isalive( self ), "<dev string:x3a3>" );
    #/
    
    self.count = count;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xf309
// Size: 0x9f
function follow_path( node, arrived_at_node_func, var_5e38f20c9628ae25 )
{
    self notify( "_utility::follow_path" );
    self endon( "_utility::follow_path" );
    self endon( "death" );
    assertmsg( "follow_path() is going to be deprecated, call go_to_node() directly" );
    oldforcegoal = self.script_forcegoal;
    self.script_forcegoal = 1;
    scripts\sp\spawner::go_to_node( node, arrived_at_node_func, var_5e38f20c9628ae25 );
    self.script_forcegoal = oldforcegoal;
    
    if ( !isdefined( self.script_forcegoal ) || !self.script_forcegoal )
    {
        self.goalradius = level.default_goalradius;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0xf3b0
// Size: 0xcb
function enable_dynamic_run_speed( followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist )
{
    setdvarifuninitialized( @"hash_c459efa5216607ee", 0 );
    disable_dynamic_run_speed( 0 );
    
    if ( !isdefined( minspeed ) )
    {
        minspeed = 0;
    }
    
    if ( !isdefined( midspeed ) )
    {
        midspeed = 205;
    }
    
    if ( !isdefined( maxspeed ) )
    {
        maxspeed = 250;
    }
    
    if ( !isdefined( frontdist ) )
    {
        frontdist = 100;
    }
    
    if ( !isdefined( middist ) )
    {
        middist = -100;
    }
    
    if ( !isdefined( backdist ) )
    {
        backdist = -200;
    }
    
    assertex( frontdist > middist, "frontDist cannot be less than midDist" );
    assertex( frontdist > backdist, "frontDist cannot be less than midDist" );
    assertex( middist > backdist, "frontDist cannot be less than midDist" );
    thread dynamic_run_speed_thread( followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xf483
// Size: 0x48
function disable_dynamic_run_speed( speed )
{
    /#
        if ( getdvarint( @"hash_c459efa5216607ee" ) )
        {
            iprintln( "<dev string:x3b6>" );
        }
    #/
    
    if ( !isdefined( speed ) )
    {
        speed = 165;
    }
    
    self notify( "stop_dynamic_run_speed" );
    
    if ( istrue( speed ) )
    {
        set_movement_speed( speed );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xf4d3
// Size: 0x86
function waittill_entity_in_range_or_timeout( entity, range, timeout )
{
    self endon( "death" );
    entity endon( "death" );
    
    if ( !isdefined( timeout ) )
    {
        timeout = 5;
    }
    
    timeout_time = gettime() + timeout * 1000;
    
    while ( isdefined( entity ) )
    {
        if ( distancesquared( entity.origin, self.origin ) <= range * range )
        {
            break;
        }
        
        if ( gettime() > timeout_time )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xf561
// Size: 0x52
function waittill_entity_in_range( entity, range )
{
    self endon( "death" );
    entity endon( "death" );
    
    while ( isdefined( entity ) )
    {
        if ( distancesquared( entity.origin, self.origin ) <= range * range )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xf5bb
// Size: 0x52
function waittill_entity_out_of_range( entity, range )
{
    self endon( "death" );
    entity endon( "death" );
    
    while ( isdefined( entity ) )
    {
        if ( distancesquared( entity.origin, self.origin ) > range * range )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xf615
// Size: 0x9a
function player_speed_percent( percent, time )
{
    currspeed = int( getdvar( @"g_speed" ) );
    
    if ( !isdefined( level.player.g_speed ) )
    {
        level.player.g_speed = currspeed;
    }
    
    goalspeed = int( level.player.g_speed * percent * 0.01 );
    level.player player_speed_set( goalspeed, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xf6b7
// Size: 0x97
function player_speed_set( speed, time )
{
    currspeed = int( getdvar( @"g_speed" ) );
    
    if ( !isdefined( level.player.g_speed ) )
    {
        level.player.g_speed = currspeed;
    }
    
    get_func = &g_speed_get_func;
    set_func = &g_speed_set_func;
    level.player thread player_speed_proc( speed, time, get_func, set_func, "player_speed_set" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xf756
// Size: 0x4d
function player_bob_scale_set( scale, time )
{
    get_func = &g_bob_scale_get_func;
    set_func = &g_bob_scale_set_func;
    level.player thread player_speed_proc( scale, time, get_func, set_func, "player_bob_scale_set" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xf7ab
// Size: 0x8e
function blend_movespeedscale( scale, time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = level.player;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        player.movespeedscale = 1;
    }
    
    get_func = &movespeed_get_func;
    set_func = &movespeed_set_func;
    player thread player_speed_proc( scale, time, get_func, set_func, "blend_movespeedscale", channel );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0xf841
// Size: 0x78
function blend_movespeedscale_percent( percent, time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = level.player;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        player.movespeedscale = 1;
    }
    
    goalscale = percent * 0.01;
    player blend_movespeedscale( goalscale, time, channel );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0xf8c1
// Size: 0xd5
function player_speed_proc( speed, time, get_func, set_func, ender, channel )
{
    self notify( ender );
    self endon( ender );
    currspeed = [[ get_func ]]( channel );
    goalspeed = speed;
    
    if ( isdefined( time ) && time > 0 )
    {
        range = goalspeed - currspeed;
        interval = 0.05;
        numcycles = time / interval;
        fraction = range / numcycles;
        
        while ( abs( goalspeed - currspeed ) > abs( fraction * 1.1 ) )
        {
            currspeed += fraction;
            [[ set_func ]]( currspeed, channel );
            wait interval;
        }
    }
    
    [[ set_func ]]( goalspeed, channel );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xf99e
// Size: 0x5b
function player_speed_default( time )
{
    if ( !isdefined( level.player.g_speed ) )
    {
        return;
    }
    
    level.player player_speed_set( level.player.g_speed, time );
    waittillframeend();
    level.player.g_speed = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xfa01
// Size: 0x5d
function blend_movespeedscale_default( time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = level.player;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        return;
    }
    
    player blend_movespeedscale( 1, time, channel );
    player.movespeedscale = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xfa66
// Size: 0x8c
function teleport_ent( ent )
{
    if ( isplayer( self ) )
    {
        self setorigin( ent.origin );
        self setplayerangles( ent.angles );
        return;
    }
    
    if ( isai( self ) )
    {
        self forceteleport( ent.origin, ent.angles );
        return;
    }
    
    self.origin = ent.origin;
    self.angles = ent.angles;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0xfafa
// Size: 0x83
function teleport_to_ent_tag( ent, tag )
{
    position = ent gettagorigin( tag );
    angles = ent gettagangles( tag );
    self dontinterpolate();
    
    if ( isplayer( self ) )
    {
        self setorigin( position );
        self setplayerangles( angles );
        return;
    }
    
    if ( isai( self ) )
    {
        self forceteleport( position, angles );
        return;
    }
    
    self.origin = position;
    self.angles = angles;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xfb85
// Size: 0x64
function teleport_ai( enode )
{
    assertex( isai( self ), "Function teleport_ai can only be called on an AI entity" );
    assertex( isdefined( enode ), "Need to pass a node entity to function teleport_ai" );
    self forceteleport( enode.origin, enode.angles );
    self setgoalpos( self.origin );
    self setgoalnode( enode );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xfbf1
// Size: 0x79
function move_all_fx( vec )
{
    foreach ( fx in level.createfxent )
    {
        fx.v[ "origin" ] = fx.v[ "origin" ] + vec;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xfc72
// Size: 0x20c
function getentwithflag( flag )
{
    trigger_classes = scripts\sp\trigger::get_load_trigger_classes();
    triggers = [];
    
    foreach ( class, _ in trigger_classes )
    {
        if ( !issubstr( class, "flag" ) )
        {
            continue;
        }
        
        other_triggers = getentarray( class, "classname" );
        triggers = array_combine( triggers, other_triggers );
    }
    
    trigger_funcs = scripts\sp\trigger::get_load_trigger_funcs();
    
    foreach ( func, _ in trigger_funcs )
    {
        if ( !issubstr( func, "flag" ) )
        {
            continue;
        }
        
        other_triggers = getentarray( func, "targetname" );
        triggers = array_combine( triggers, other_triggers );
    }
    
    found_trigger = undefined;
    
    /#
        foreach ( trigger in triggers )
        {
            assertex( isdefined( trigger.script_flag ), "<dev string:x3cd>" + trigger.origin + "<dev string:x3de>" );
            
            if ( trigger.script_flag == flag )
            {
                assertex( !isdefined( found_trigger ), "<dev string:x3f2>" + flag + "<dev string:x40e>" );
                found_trigger = trigger;
            }
        }
    #/
    
    foreach ( trigger in triggers )
    {
        if ( trigger.script_flag == flag )
        {
            return trigger;
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0xfe86
// Size: 0x21a
function getentarraywithflag( flag )
{
    trigger_classes = scripts\sp\trigger::get_load_trigger_classes();
    triggers = [];
    
    foreach ( class, _ in trigger_classes )
    {
        if ( !issubstr( class, "flag" ) )
        {
            continue;
        }
        
        other_triggers = getentarray( class, "classname" );
        triggers = array_combine( triggers, other_triggers );
    }
    
    trigger_funcs = scripts\sp\trigger::get_load_trigger_funcs();
    
    foreach ( func, _ in trigger_funcs )
    {
        if ( !issubstr( func, "flag" ) )
        {
            continue;
        }
        
        other_triggers = getentarray( func, "targetname" );
        triggers = array_combine( triggers, other_triggers );
    }
    
    found_triggers = [];
    
    /#
        foreach ( trigger in triggers )
        {
            assertex( isdefined( trigger.script_flag ), "<dev string:x3cd>" + trigger.origin + "<dev string:x3de>" );
            
            if ( trigger.script_flag == flag )
            {
                found_triggers[ found_triggers.size ] = trigger;
            }
        }
        
        assertex( found_triggers.size, "<dev string:x43a>" + flag + "<dev string:x45a>" );
        
        if ( true )
        {
            return found_triggers;
        }
    #/
    
    foreach ( trigger in triggers )
    {
        if ( trigger.script_flag == flag )
        {
            found_triggers[ found_triggers.size ] = trigger;
        }
    }
    
    return found_triggers;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x100a9
// Size: 0x1c
function set_z( vec, z )
{
    return ( vec[ 0 ], vec[ 1 ], z );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x100ce
// Size: 0x1c
function set_y( vec, y )
{
    return ( vec[ 0 ], y, vec[ 2 ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x100f3
// Size: 0x1d
function set_x( vec, x )
{
    return ( x, vec[ 1 ], vec[ 2 ] );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x10119
// Size: 0x5d
function get_rumble_ent( rumble )
{
    player = get_player_from_self();
    
    if ( !isdefined( rumble ) )
    {
        rumble = "steady_rumble";
    }
    
    ent = spawn( "script_origin", player geteye() );
    ent.intensity = 1;
    ent thread update_rumble_intensity( player, rumble );
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1017f
// Size: 0x2e
function set_rumble_intensity( intensity )
{
    assertex( intensity >= 0 && intensity <= 1, "Intensity must be between 0 and 1" );
    self.intensity = intensity;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x101b5
// Size: 0x16
function rumble_ramp_on( time )
{
    thread rumble_ramp_to( 1, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x101d3
// Size: 0x15
function rumble_ramp_off( time )
{
    thread rumble_ramp_to( 0, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x101f0
// Size: 0x98
function rumble_ramp_to( dest, time )
{
    self notify( "new_ramp" );
    self endon( "new_ramp" );
    self endon( "death" );
    frames = time * 20;
    dif = dest - self.intensity;
    slice = dif / frames;
    
    for ( i = 0; i < frames ; i++ )
    {
        self.intensity += slice;
        wait 0.05;
    }
    
    self.intensity = dest;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x10290
// Size: 0x36
function get_player_from_self()
{
    if ( isdefined( self ) )
    {
        if ( !array_contains( level.players, self ) )
        {
            return level.player;
        }
        else
        {
            return self;
        }
        
        return;
    }
    
    return level.player;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x102ce
// Size: 0x26
function get_player_gameskill()
{
    assertex( isplayer( self ), "get_player_gameskill() can only be called on a player." );
    return int( self getplayersetting( "gameskill" ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x102fd
// Size: 0x13f
function array_delete_evenly( array, delete_size, set_size )
{
    assertex( delete_size > 0, "Save size must be at least 1" );
    assertex( set_size > 0, "Removal size must be at least 1" );
    assertex( delete_size < set_size, "Save size must be less than removal size" );
    removal = [];
    delete_size = set_size - delete_size;
    
    foreach ( entry in array )
    {
        removal[ removal.size ] = entry;
        
        if ( removal.size == set_size )
        {
            removal = array_randomize( removal );
            
            for ( i = delete_size; i < removal.size ; i++ )
            {
                removal[ i ] delete();
            }
            
            removal = [];
        }
    }
    
    new_array = [];
    
    foreach ( entry in array )
    {
        if ( !isdefined( entry ) )
        {
            continue;
        }
        
        new_array[ new_array.size ] = entry;
    }
    
    return new_array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x10445
// Size: 0x51
function waittill_in_range( origin, range, resolution )
{
    if ( !isdefined( resolution ) )
    {
        resolution = 0.5;
    }
    
    self endon( "death" );
    
    while ( isdefined( self ) )
    {
        if ( distancesquared( origin, self.origin ) <= range * range )
        {
            break;
        }
        
        wait resolution;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x1049e
// Size: 0x51
function waittill_out_of_range( origin, range, resolution )
{
    if ( !isdefined( resolution ) )
    {
        resolution = 0.5;
    }
    
    self endon( "death" );
    
    while ( isdefined( self ) )
    {
        if ( distancesquared( origin, self.origin ) > range * range )
        {
            break;
        }
        
        wait resolution;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x104f7
// Size: 0x13
function enable_surprise()
{
    self.newenemyreactiondistsq = squared( 512 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x10512
// Size: 0x7
function getvehiclearray()
{
    return vehicle_getarray();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x10522
// Size: 0xa0
function getteamvehiclearray( teams )
{
    if ( !isarray( teams ) )
    {
        teams[ 0 ] = teams;
    }
    
    vehicles = vehicle_getarray();
    
    foreach ( vehicle in vehicles )
    {
        if ( isdefined( vehicle.team ) && array_contains( teams, vehicle.team ) )
        {
            continue;
        }
        
        vehicles = array_remove( vehicles, vehicle );
    }
    
    return vehicles;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x105cb
// Size: 0xa8
function getvehiclearray_in_radius( pos, dist, team )
{
    vehicles = get_array_of_closest( pos, vehicle_getarray(), undefined, undefined, dist );
    
    if ( isdefined( team ) )
    {
        temp_array = [];
        
        foreach ( vehicle in vehicles )
        {
            if ( is_equal( vehicle.script_team, team ) )
            {
                temp_array[ temp_array.size ] = vehicle;
            }
        }
        
        vehicles = temp_array;
    }
    
    return vehicles;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x1067c
// Size: 0x152
function hint( string, timeout, zoffset )
{
    if ( !isdefined( zoffset ) )
    {
        zoffset = 0;
    }
    
    hintfade = 0.5;
    level endon( "clearing_hints" );
    
    if ( isdefined( level.hintelement ) )
    {
        level.hintelement scripts\sp\hud_util::destroyelem();
    }
    
    level.hintelement = scripts\sp\hud_util::createfontstring( "default", 1.5 );
    level.hintelement scripts\sp\hud_util::setpoint( "MIDDLE", undefined, 0, 30 + zoffset );
    level.hintelement.color = ( 1, 1, 1 );
    level.hintelement settext( string );
    level.hintelement.alpha = 0;
    level.hintelement fadeovertime( 0.5 );
    level.hintelement.alpha = 1;
    wait 0.5;
    level.hintelement endon( "death" );
    
    if ( isdefined( timeout ) )
    {
        wait timeout;
    }
    else
    {
        return;
    }
    
    level.hintelement fadeovertime( hintfade );
    level.hintelement.alpha = 0;
    wait hintfade;
    level.hintelement scripts\sp\hud_util::destroyelem();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x107d6
// Size: 0x4b
function hint_fade()
{
    hintfade = 1;
    
    if ( isdefined( level.hintelement ) )
    {
        level notify( "clearing_hints" );
        level.hintelement fadeovertime( hintfade );
        level.hintelement.alpha = 0;
        wait hintfade;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x10829
// Size: 0xd8
function kill_deathflag( theflag, time )
{
    if ( !isdefined( level.flag[ theflag ] ) )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    foreach ( deathtypes in level.deathflags[ theflag ] )
    {
        foreach ( element in deathtypes )
        {
            if ( isalive( element ) )
            {
                element thread kill_deathflag_proc( time );
                continue;
            }
            
            element delete();
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x10909
// Size: 0xbd
function get_player_view_controller( model, tag, originoffset, turret )
{
    if ( !isdefined( turret ) )
    {
        turret = "player_view_controller";
    }
    
    if ( !isdefined( originoffset ) )
    {
        originoffset = ( 0, 0, 0 );
    }
    
    origin = model gettagorigin( tag );
    player_view_controller = spawnturret( "misc_turret", origin, turret );
    player_view_controller.angles = model gettagangles( tag );
    player_view_controller setmodel( "tag_turret" );
    player_view_controller linkto( model, tag, originoffset, ( 0, 0, 0 ) );
    player_view_controller makeunusable();
    player_view_controller hide();
    player_view_controller setmode( "manual" );
    return player_view_controller;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x109cf
// Size: 0x42
function create_blend( func, var1, var2, var3 )
{
    ent = spawnstruct();
    ent childthread process_blend( func, self, var1, var2, var3 );
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x10a1a
// Size: 0x11b
function store_players_weapons( scene )
{
    if ( !isdefined( self.stored_weapons ) )
    {
        self.stored_weapons = [];
    }
    
    array = [];
    weapons = self getweaponslistall();
    
    foreach ( weapon in weapons )
    {
        weaponname = getcompleteweaponname( weapon );
        array[ weaponname ] = [];
        array[ weaponname ][ "clip_left" ] = self getweaponammoclip( weapon, "left" );
        array[ weaponname ][ "clip_right" ] = self getweaponammoclip( weapon, "right" );
        array[ weaponname ][ "stock" ] = self getweaponammostock( weapon );
    }
    
    if ( !isdefined( scene ) )
    {
        scene = "default";
    }
    
    self.stored_weapons[ scene ] = [];
    self.stored_weapons[ scene ][ "current_weapon" ] = self getcurrentweapon();
    self.stored_weapons[ scene ][ "inventory" ] = array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x10b3d
// Size: 0x137
function restore_players_weapons( scene, immediate )
{
    if ( !isdefined( scene ) )
    {
        scene = "default";
    }
    
    if ( !isdefined( self.stored_weapons ) || !isdefined( self.stored_weapons[ scene ] ) )
    {
        println( "<dev string:x46a>" + scene + "<dev string:x499>" );
        return;
    }
    
    self takeallweapons();
    
    foreach ( weapon, array in self.stored_weapons[ scene ][ "inventory" ] )
    {
        if ( weaponinventorytype( weapon ) != "altmode" )
        {
            self giveweapon( weapon );
        }
        
        self setweaponammoclip( weapon, array[ "clip_left" ], "left" );
        self setweaponammoclip( weapon, array[ "clip_right" ], "right" );
        self setweaponammostock( weapon, array[ "stock" ] );
    }
    
    current_weapon = self.stored_weapons[ scene ][ "current_weapon" ];
    
    if ( !isnullweapon( current_weapon ) )
    {
        if ( istrue( immediate ) )
        {
            self switchtoweaponimmediate( current_weapon );
            return;
        }
        
        self switchtoweapon( current_weapon );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x10c7c
// Size: 0x112
function hide_entity()
{
    switch ( self.code_classname )
    {
        case #"hash_3872eb7d97592cac":
        case #"hash_3e0cb1082de9d2a8":
        case #"hash_4af55147c6098215":
            self hide();
            break;
        case #"hash_6318af6067faf262":
            self hide();
            self notsolid();
            
            if ( self.spawnflags & 1 )
            {
                self connectpaths();
            }
            
            break;
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_56b6f012db0ab679":
        case #"hash_5bb64935d67fde88":
        case #"hash_5e80cefd309127e7":
        case #"hash_747275424b5fb89f":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_8c50f3158618de8d":
        case #"hash_b19df071202be3de":
            trigger_off();
            break;
        default:
            assertmsg( "Unable to hide entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname );
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x10d96
// Size: 0x112
function show_entity()
{
    switch ( self.code_classname )
    {
        case #"hash_3872eb7d97592cac":
        case #"hash_3e0cb1082de9d2a8":
        case #"hash_4af55147c6098215":
            self show();
            break;
        case #"hash_6318af6067faf262":
            self show();
            self solid();
            
            if ( self.spawnflags & 1 )
            {
                self disconnectpaths();
            }
            
            break;
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_56b6f012db0ab679":
        case #"hash_5bb64935d67fde88":
        case #"hash_5e80cefd309127e7":
        case #"hash_747275424b5fb89f":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_8c50f3158618de8d":
        case #"hash_b19df071202be3de":
            trigger_on();
            break;
        default:
            assertmsg( "Unable to show entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname );
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x10eb0
// Size: 0xb3
function set_moveplaybackrate( rate, time )
{
    self notify( "set_moveplaybackrate" );
    self endon( "set_moveplaybackrate" );
    self endon( "death" );
    
    if ( isdefined( time ) )
    {
        current_rate = asm_getmoveplaybackrate();
        range = rate - current_rate;
        interval = 0.05;
        numcycles = time / interval;
        fraction = range / numcycles;
        
        while ( abs( rate - current_rate ) > abs( fraction * 1.1 ) )
        {
            asm_setmoveplaybackrate( current_rate + fraction );
            wait interval;
            current_rate = asm_getmoveplaybackrate();
        }
    }
    
    asm_setmoveplaybackrate( rate );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x10f6b
// Size: 0xd0
function array_spawn_function( array, func, param1, param2, param3, param4 )
{
    assertex( isdefined( array ), "That isn't an array!" );
    assertex( isarray( array ), "That isn't an array!" );
    assertex( array.size, "That array is empty!" );
    
    foreach ( spawner in array )
    {
        assertex( isspawner( spawner ), "This isn't a spawner!" );
        spawner thread add_spawn_function( func, param1, param2, param3, param4 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x11043
// Size: 0x67
function array_spawn_function_targetname( key, func, param1, param2, param3, param4 )
{
    array = getspawnerarray( key );
    array = array_merge( array, getentarray( key, "targetname" ) );
    array_spawn_function( array, func, param1, param2, param3, param4 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x110b2
// Size: 0x6d
function array_spawn_function_noteworthy( key, func, param1, param2, param3, param4 )
{
    array = get_spawner_array( key, "script_noteworthy" );
    array = array_merge( array, getentarray( key, "script_noteworthy" ) );
    array_spawn_function( array, func, param1, param2, param3, param4 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 6
// Checksum 0x0, Offset: 0x11127
// Size: 0x53
function array_spawn_function_aigroup( key, func, param1, param2, param3, param4 )
{
    array = get_ai_group_spawners( key );
    array_spawn_function( array, func, param1, param2, param3, param4 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11182
// Size: 0xd
function enable_dontevershoot()
{
    self.dontevershoot = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11197
// Size: 0xc
function disable_dontevershoot()
{
    self.dontevershoot = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x111ab
// Size: 0x17c
function mask_exploders_in_volume( volumes )
{
    if ( getdvar( @"createfx" ) != "" )
    {
        return;
    }
    
    ents = getentarray( "script_brushmodel", "classname" );
    smodels = getentarray( "script_model", "classname" );
    
    for ( i = 0; i < smodels.size ; i++ )
    {
        ents[ ents.size ] = smodels[ i ];
    }
    
    foreach ( volume in volumes )
    {
        foreach ( ent in ents )
        {
            if ( isdefined( ent.script_prefab_exploder ) )
            {
                ent.script_exploder = ent.script_prefab_exploder;
            }
            
            if ( !isdefined( ent.script_exploder ) )
            {
                continue;
            }
            
            if ( !isdefined( ent.model ) )
            {
                continue;
            }
            
            if ( ent.code_classname != "script_model" )
            {
                continue;
            }
            
            if ( !ent istouching( volume ) )
            {
                continue;
            }
            
            ent.masked_exploder = 1;
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1132f
// Size: 0x200
function activate_exploders_in_volume()
{
    test_org = spawn( "script_origin", ( 0, 0, 0 ) );
    
    foreach ( entfx in level.createfxent )
    {
        if ( !isdefined( entfx.v[ "masked_exploder" ] ) )
        {
            continue;
        }
        
        test_org.origin = entfx.v[ "origin" ];
        test_org.angles = entfx.v[ "angles" ];
        
        if ( !test_org istouching( self ) )
        {
            continue;
        }
        
        model_name = entfx.v[ "masked_exploder" ];
        spawnflags = entfx.v[ "masked_exploder_spawnflags" ];
        disconnect_paths = entfx.v[ "masked_exploder_script_disconnectpaths" ];
        new_ent = spawn( "script_model", ( 0, 0, 0 ), spawnflags );
        new_ent setmodel( model_name );
        new_ent.origin = entfx.v[ "origin" ];
        new_ent.angles = entfx.v[ "angles" ];
        entfx.v[ "masked_exploder" ] = undefined;
        entfx.v[ "masked_exploder_spawnflags" ] = undefined;
        entfx.v[ "masked_exploder_script_disconnectpaths" ] = undefined;
        new_ent.disconnect_paths = disconnect_paths;
        new_ent.script_exploder = entfx.v[ "exploder" ];
        scripts\common\exploder::setup_individual_exploder( new_ent );
        entfx.model = new_ent;
    }
    
    test_org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x11537
// Size: 0x19d
function delete_destructibles_in_volumes( volumes, dodelayed )
{
    foreach ( volume in volumes )
    {
        volume.destructibles = [];
    }
    
    names = [ "destructible_toy", "destructible_vehicle" ];
    incs = 0;
    
    if ( !isdefined( dodelayed ) )
    {
        dodelayed = 0;
    }
    
    foreach ( name in names )
    {
        destructible_toy = getentarray( name, "targetname" );
        
        foreach ( toy in destructible_toy )
        {
            foreach ( volume in volumes )
            {
                if ( dodelayed )
                {
                    incs++;
                    incs %= 5;
                    
                    if ( incs == 1 )
                    {
                        wait 0.05;
                    }
                }
                
                if ( !volume istouching( toy ) )
                {
                    continue;
                }
                
                toy delete();
                break;
            }
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x116dc
// Size: 0x17d
function delete_exploders_in_volumes( volumes, dodelayed )
{
    ents = getentarray( "script_brushmodel", "classname" );
    smodels = getentarray( "script_model", "classname" );
    
    for ( i = 0; i < smodels.size ; i++ )
    {
        ents[ ents.size ] = smodels[ i ];
    }
    
    delete_ents = [];
    test_org = spawn( "script_origin", ( 0, 0, 0 ) );
    incs = 0;
    
    if ( !isdefined( dodelayed ) )
    {
        dodelayed = 0;
    }
    
    foreach ( volume in volumes )
    {
        foreach ( ent in ents )
        {
            if ( !isdefined( ent.script_exploder ) )
            {
                continue;
            }
            
            test_org.origin = ent getorigin();
            
            if ( !volume istouching( test_org ) )
            {
                continue;
            }
            
            delete_ents[ delete_ents.size ] = ent;
        }
    }
    
    array_delete( delete_ents );
    test_org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11861
// Size: 0xb7
function waittill_volume_dead()
{
    for ( ;; )
    {
        ai = getaispeciesarray( "axis", "all" );
        found_guy = 0;
        
        foreach ( guy in ai )
        {
            if ( !isalive( guy ) )
            {
                continue;
            }
            
            if ( guy istouching( self ) )
            {
                found_guy = 1;
                break;
            }
            
            wait 0.0125;
        }
        
        if ( !found_guy )
        {
            ahostiles = get_ai_touching_volume( "axis" );
            
            if ( !ahostiles.size )
            {
                break;
            }
        }
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11920
// Size: 0xdd
function waittill_volume_dead_or_dying()
{
    var_68261d6b57587746 = 0;
    
    for ( ;; )
    {
        ai = getaispeciesarray( "axis", "all" );
        found_guy = 0;
        
        foreach ( guy in ai )
        {
            if ( !isalive( guy ) )
            {
                continue;
            }
            
            if ( guy istouching( self ) )
            {
                if ( guy doinglongdeath() )
                {
                    continue;
                }
                
                found_guy = 1;
                var_68261d6b57587746 = 1;
                break;
            }
            
            wait 0.0125;
        }
        
        if ( !found_guy )
        {
            ahostiles = get_ai_touching_volume( "axis" );
            
            if ( !ahostiles.size )
            {
                break;
            }
            else
            {
                var_68261d6b57587746 = 1;
            }
        }
        
        wait 0.05;
    }
    
    return var_68261d6b57587746;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11a06
// Size: 0x1a
function waittill_volume_dead_then_set_flag( sflag )
{
    waittill_volume_dead();
    flag_set( sflag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x11a28
// Size: 0x44
function waittill_targetname_volume_dead_then_set_flag( targetname, msg )
{
    volume = getent( targetname, "targetname" );
    assertex( isdefined( volume ), "No volume for targetname " + targetname );
    volume waittill_volume_dead_then_set_flag( msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11a74
// Size: 0x68
function array_index_by_parameters( old_array )
{
    array = [];
    
    foreach ( item in old_array )
    {
        array[ item.script_parameters ] = item;
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11ae5
// Size: 0x68
function array_index_by_classname( old_array )
{
    array = [];
    
    foreach ( item in old_array )
    {
        array[ item.classname ] = item;
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11b56
// Size: 0xa0
function array_index_by_script_index( array )
{
    newarray = [];
    
    foreach ( ent in array )
    {
        if ( isdefined( ent.script_index ) )
        {
            assertex( !isdefined( newarray[ ent.script_index ] ), "Multiple ents had the same script_index of " + ent.script_index );
            newarray[ ent.script_index ] = ent;
        }
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11bff
// Size: 0x8c
function get_color_volume_from_trigger()
{
    info = get_color_info_from_trigger();
    team = info[ "team" ];
    
    foreach ( code in info[ "codes" ] )
    {
        volume = level.arrays_of_colorcoded_volumes[ team ][ code ];
        
        if ( isdefined( volume ) )
        {
            return volume;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11c94
// Size: 0x8c
function get_color_nodes_from_trigger()
{
    info = get_color_info_from_trigger();
    team = info[ "team" ];
    
    foreach ( code in info[ "codes" ] )
    {
        nodes = level.arrays_of_colorcoded_nodes[ team ][ code ];
        
        if ( isdefined( nodes ) )
        {
            return nodes;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11d29
// Size: 0x11
function get_splineid( targetname )
{
    return getcsplineid( targetname );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11d43
// Size: 0x11
function get_splineidarray( targetname )
{
    return getcsplineidarray( targetname );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11d5d
// Size: 0x2b
function earthquake_and_rumble( position )
{
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.4, 0.5, position, 400 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x11d90
// Size: 0x34
function pathrandompercent_set( value )
{
    if ( !isdefined( self.old_pathrandompercent ) )
    {
        self.old_pathrandompercent = self.pathrandompercent;
    }
    
    self.pathrandompercent = value;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11dcc
// Size: 0x2c
function pathrandompercent_zero()
{
    if ( isdefined( self.old_pathrandompercent ) )
    {
        return;
    }
    
    self.old_pathrandompercent = self.pathrandompercent;
    self.pathrandompercent = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11e00
// Size: 0x1e
function pathrandompercent_reset()
{
    self.pathrandompercent = self.old_pathrandompercent;
    self.old_pathrandompercent = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11e26
// Size: 0x48
function walkdist_zero()
{
    if ( isdefined( self.old_walkdistfacingmotion ) )
    {
        return;
    }
    
    self.old_walkdist = self.walkdist;
    self.old_walkdistfacingmotion = self.walkdistfacingmotion;
    self.walkdist = 0;
    self.walkdistfacingmotion = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11e76
// Size: 0x60
function walkdist_reset()
{
    assert( isdefined( self.old_walkdist ) );
    assert( isdefined( self.old_walkdistfacingmotion ) );
    self.walkdist = self.old_walkdist;
    self.walkdistfacingmotion = self.old_walkdistfacingmotion;
    self.old_walkdist = undefined;
    self.old_walkdistfacingmotion = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11ede
// Size: 0xa
function enable_ignorerandombulletdamage_drone()
{
    thread ignorerandombulletdamage_drone_proc();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11ef0
// Size: 0xd9
function ignorerandombulletdamage_drone_proc()
{
    assertex( !issentient( self ), "AI tried to run enable_ignorerandombulletdamage_drone" );
    self endon( "disable_ignorerandombulletdamage_drone" );
    self endon( "death" );
    self.ignorerandombulletdamage = 1;
    self.fakehealth = self.health;
    self.health = 1000000;
    
    while ( true )
    {
        self waittill( "damage", damage, attacker );
        
        if ( !isplayer( attacker ) && issentient( attacker ) )
        {
            if ( isdefined( attacker.enemy ) && attacker.enemy != self )
            {
                continue;
            }
        }
        
        self.fakehealth -= damage;
        
        if ( self.fakehealth <= 0 )
        {
            break;
        }
    }
    
    self kill();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11fd1
// Size: 0x19
function hide_notsolid()
{
    if ( !isai( self ) )
    {
        self notsolid();
    }
    
    self hide();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x11ff2
// Size: 0x19
function show_solid()
{
    if ( !isai( self ) )
    {
        self solid();
    }
    
    self show();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12013
// Size: 0x15
function set_brakes( num )
{
    self.veh_brake = num;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x12030
// Size: 0x3e
function disable_ignorerandombulletdamage_drone()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.ignorerandombulletdamage ) )
    {
        return;
    }
    
    self notify( "disable_ignorerandombulletdamage_drone" );
    self.ignorerandombulletdamage = undefined;
    self.health = self.fakehealth;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12076
// Size: 0x2f
function timeoutent( timeout )
{
    ent = spawnstruct();
    ent delaythread( timeout, &send_notify, "timeout" );
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 8
// Checksum 0x0, Offset: 0x120ae
// Size: 0x55
function delaychildthread( timer, func, param1, param2, param3, param4, param5, param6 )
{
    childthread delaychildthread_proc( func, timer, param1, param2, param3, param4, param5, param6 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x1210b
// Size: 0x63
function flagwaitthread( flag, func, param1, param2, param3, param4, param5 )
{
    if ( !isarray( flag ) )
    {
        flag = [ flag, 0 ];
    }
    
    thread flagwaitthread_proc( func, flag, param1, param2, param3, param4, param5 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 7
// Checksum 0x0, Offset: 0x12176
// Size: 0x6a
function waittillthread( note, func, param1, param2, param3, param4, param5 )
{
    self endon( "death" );
    
    if ( !isarray( note ) )
    {
        note = [ note, 0 ];
    }
    
    thread waittillthread_proc( func, note, param1, param2, param3, param4, param5 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x121e8
// Size: 0x21
function set_group_advance_to_enemy_parameters( interval, group_size )
{
    setadvancetoenemyinterval( interval );
    setadvancetoenemygroupmax( group_size );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x12211
// Size: 0x27
function set_battlechatter_variable( team, val )
{
    level.battlechatter[ team ] = val;
    update_battlechatter_hud();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12240
// Size: 0x7f
function get_minutes_and_seconds( milliseconds )
{
    time = [];
    time[ "minutes" ] = 0;
    time[ "seconds" ] = int( milliseconds / 1000 );
    
    while ( time[ "seconds" ] >= 60 )
    {
        time[ "minutes" ]++;
        time[ "seconds" ] = time[ "seconds" ] - 60;
    }
    
    if ( time[ "seconds" ] < 10 )
    {
        time[ "seconds" ] = "0" + time[ "seconds" ];
    }
    
    return time;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x122c8
// Size: 0xbf, Type: bool
function player_has_weapon( weap )
{
    objweapon = weap;
    
    if ( isstring( weap ) )
    {
        attachments = getweapondefaultattachments( weap );
        
        if ( istrue( attachments.size ) )
        {
            objweapon = makeweapon( weap, attachments );
        }
        else
        {
            objweapon = makeweaponfromstring( weap );
        }
    }
    
    weaponlist = level.player.primaryinventory;
    
    foreach ( weapon in weaponlist )
    {
        if ( issameweapon( weapon, objweapon, 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12390
// Size: 0xa5, Type: bool
function player_has_base_weapon( weap )
{
    objweapon = weap;
    
    if ( isstring( weap ) )
    {
        objweapon = makeweaponfromstring( weap );
    }
    
    weaponlist = level.player.primaryinventory;
    
    foreach ( weapon in weaponlist )
    {
        if ( weapon.basename == objweapon.basename )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1243e
// Size: 0xc7, Type: bool
function player_has_equipment( weap, includestored )
{
    objweapon = weap;
    
    if ( isstring( weap ) )
    {
        attachments = getweapondefaultattachments( weap );
        
        if ( istrue( attachments.size ) )
        {
            objweapon = makeweapon( weap, attachments );
        }
        else
        {
            objweapon = makeweaponfromstring( weap );
        }
    }
    
    equiplist = level.player.offhandinventory;
    
    foreach ( weapon in equiplist )
    {
        if ( issameweapon( weapon, objweapon, 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x1250e
// Size: 0x7b
function graph_position( v, min_x, min_y, max_x, max_y )
{
    rise = max_y - min_y;
    run = max_x - min_x;
    assertex( run != 0, "max and min x must be different, or you havent defined any graph space." );
    slope = rise / run;
    v -= max_x;
    v = slope * v;
    v += max_y;
    return v;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12592
// Size: 0x3f
function musiclength( alias )
{
    time = lookupsoundlength( alias );
    assertex( time > 0, "Music alias " + alias + " had zero time." );
    time *= 0.001;
    return time;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x125da
// Size: 0x23
function is_command_bound( cmd )
{
    binding = getkeybinding( cmd );
    return binding[ "count" ];
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12606
// Size: 0x26
function template_level( levelname )
{
    iprintlnbold( "remove 'template_level( " + levelname + " );' from " + levelname + ".gsc - this will error as of 5/19" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x12634
// Size: 0x1d
function fx_volume_pause_noteworthy( noteworthy, dodelayed )
{
    thread fx_volume_pause_noteworthy_thread( noteworthy, dodelayed );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x12659
// Size: 0x47
function fx_volume_pause_noteworthy_thread( noteworthy, dodelayed )
{
    volume = getent( noteworthy, "script_noteworthy" );
    volume notify( "new_volume_command" );
    volume endon( "new_volume_command" );
    wait 0.05;
    fx_volume_pause( volume, dodelayed );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x126a8
// Size: 0x14
function fx_volume_restart_noteworthy( noteworthy )
{
    thread fx_volume_restart_noteworthy_thread( noteworthy );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x126c4
// Size: 0x59
function fx_volume_restart_noteworthy_thread( noteworthy )
{
    volume = getent( noteworthy, "script_noteworthy" );
    volume notify( "new_volume_command" );
    volume endon( "new_volume_command" );
    wait 0.05;
    
    if ( !isdefined( volume.fx_paused ) )
    {
        return;
    }
    
    volume.fx_paused = undefined;
    fx_volume_restart( volume );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12725
// Size: 0x2d
function fx_volume_restart( volume )
{
    assert( isdefined( volume ) );
    array_thread( volume.fx, &restarteffect );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1275a
// Size: 0x9c
function add_cleanup_ent( ent, groupname )
{
    assert( isdefined( ent ) );
    assert( isdefined( groupname ) );
    
    if ( !isdefined( level.cleanup_ents ) )
    {
        level.cleanup_ents = [];
    }
    
    if ( !isdefined( level.cleanup_ents[ groupname ] ) )
    {
        level.cleanup_ents[ groupname ] = [];
    }
    
    /#
        if ( array_contains( level.cleanup_ents[ groupname ], ent ) )
        {
            assertmsg( "<dev string:x4b2>" );
        }
    #/
    
    level.cleanup_ents[ groupname ][ level.cleanup_ents[ groupname ].size ] = ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x127fe
// Size: 0x65
function cleanup_ents( groupname )
{
    assert( isdefined( level.cleanup_ents ) );
    assert( isdefined( level.cleanup_ents[ groupname ] ) );
    array = level.cleanup_ents[ groupname ];
    array = array_removeundefined( array );
    array_delete( array );
    level.cleanup_ents[ groupname ] = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1286b
// Size: 0xdf
function cleanup_ents_removing_bullet_shield( groupname )
{
    if ( !isdefined( level.cleanup_ents ) )
    {
        return;
    }
    
    if ( !isdefined( level.cleanup_ents[ groupname ] ) )
    {
        return;
    }
    
    array = level.cleanup_ents[ groupname ];
    array = array_removeundefined( array );
    
    foreach ( obj in array )
    {
        if ( !isai( obj ) )
        {
            continue;
        }
        
        if ( !isalive( obj ) )
        {
            continue;
        }
        
        if ( !isdefined( obj.magic_bullet_shield ) )
        {
            continue;
        }
        
        if ( !obj.magic_bullet_shield )
        {
            continue;
        }
        
        obj stop_magic_bullet_shield();
    }
    
    array_delete( array );
    level.cleanup_ents[ groupname ] = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12952
// Size: 0x36
function add_trigger_function( function )
{
    if ( !isdefined( self.trigger_functions ) )
    {
        thread add_trigger_func_thread();
    }
    
    self.trigger_functions[ self.trigger_functions.size ] = function;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12990
// Size: 0x36
function function_1c0a584731a90429( function )
{
    if ( !isdefined( self.var_f08830decd9eb50a ) )
    {
        thread function_d4c885c9ef5c6bc8();
    }
    
    self.var_f08830decd9eb50a[ self.var_f08830decd9eb50a.size ] = function;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x129ce
// Size: 0x91
function getallweapons()
{
    array = [];
    entities = getentarray();
    
    foreach ( ent in entities )
    {
        if ( !isdefined( ent.classname ) )
        {
            continue;
        }
        
        if ( string_starts_with( ent.classname, "weapon_" ) )
        {
            array[ array.size ] = ent;
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x12a68
// Size: 0xc3
function move_with_rate( origin, angles, moverate )
{
    assert( isdefined( origin ) );
    assert( isdefined( angles ) );
    assert( isdefined( moverate ) );
    self notify( "newmove" );
    self endon( "newmove" );
    
    if ( !isdefined( moverate ) )
    {
        moverate = 200;
    }
    
    dist = distance( self.origin, origin );
    movetime = dist / moverate;
    movevec = vectornormalize( origin - self.origin );
    self moveto( origin, movetime, 0, 0 );
    self rotateto( angles, movetime, 0, 0 );
    wait movetime;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.velocity = movevec * dist / movetime;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12b33
// Size: 0x1e
function flag_on_death( msg )
{
    level endon( msg );
    self waittill( "death" );
    flag_set( msg );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x12b59
// Size: 0xd
function enable_damagefeedback()
{
    level.damagefeedback = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x12b6e
// Size: 0xc
function disable_damagefeedback()
{
    level.damagefeedback = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x12b82
// Size: 0x19, Type: bool
function is_damagefeedback_enabled()
{
    return isdefined( level.damagefeedback ) && level.damagefeedback;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12ba4
// Size: 0x64
function worldtolocalcoords( world_vec )
{
    var_f3589428c6ee8c59 = world_vec - self.origin;
    return ( vectordot( var_f3589428c6ee8c59, anglestoforward( self.angles ) ), -1 * vectordot( var_f3589428c6ee8c59, anglestoright( self.angles ) ), vectordot( var_f3589428c6ee8c59, anglestoup( self.angles ) ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x12c11
// Size: 0x57
function sound_fade_and_delete( fade, is_loop )
{
    self scalevolume( 0, fade );
    
    if ( istrue( is_loop ) )
    {
        delaycall( fade + 0.05, &stoploopsound );
    }
    else
    {
        delaycall( fade + 0.05, &stopsounds );
    }
    
    delaycall( fade + 0.1, &delete );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x12c70
// Size: 0x83
function sound_fade_in( alias, volume, fade, is_loop )
{
    self endon( "death" );
    volume = clamp( volume, 0, 1 );
    fade = max( 0.05, fade );
    self scalevolume( 0 );
    wait 0.05;
    
    if ( isdefined( is_loop ) )
    {
        self playloopsound( alias );
    }
    else
    {
        self playsound( alias );
    }
    
    wait 0.05;
    delaycall( 0.05, &scalevolume, volume, fade );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x12cfb
// Size: 0x125
function function_e0d4c67fc1a382d0( alias, offset, fadein, fadeout )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( "death" );
    thread delete_on_death( org );
    
    if ( isdefined( offset ) )
    {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto( self );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    if ( isdefined( fadein ) && fadein > 0 )
    {
        org scalevolume( 0 );
    }
    
    org playloopsound( alias );
    
    if ( isdefined( fadein ) && fadein > 0 )
    {
        org scalevolume( 1, fadein );
    }
    
    self waittill( "stop sound" + alias );
    
    if ( isdefined( fadeout ) && fadeout > 0 )
    {
        org scalevolume( 0, fadeout );
        wait fadeout;
    }
    
    org stoploopsound( alias );
    org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x12e28
// Size: 0xd3
function intro_screen_create( string1, string2, string3, string4, string5 )
{
    if ( !isdefined( level.introscreen ) )
    {
        level.introscreen = spawnstruct();
    }
    
    level.introscreen.completed_delay = 3;
    level.introscreen.fade_out_time = 1.5;
    level.introscreen.fade_in_time = undefined;
    level.introscreen.lines = [ string1, string2, string3, string4, string5 ];
    noself_array_call( level.introscreen.lines, &precachestring );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12f03
// Size: 0x3b
function intro_screen_custom_func( function )
{
    if ( !isdefined( level.introscreen ) )
    {
        level.introscreen = spawnstruct();
    }
    
    level.introscreen.customfunc = function;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x12f46
// Size: 0x12a
function function_8ac37772d2e1050b( var_20e7486efb53100d )
{
    /#
        function_64c8bf68f2b25ffe( var_20e7486efb53100d );
    #/
    
    if ( !isdefined( level.transient_sets ) )
    {
        level.transient_sets = [];
    }
    else if ( isdefined( level.transient_sets[ var_20e7486efb53100d ] ) && level.transient_sets[ var_20e7486efb53100d ] == 1 )
    {
        return;
    }
    
    switchtransientset( var_20e7486efb53100d );
    transient_names = gettransientsinset( var_20e7486efb53100d );
    
    foreach ( transient in transient_names )
    {
        while ( !istransientloaded( transient ) )
        {
            waitframe();
        }
    }
    
    foreach ( index, item in level.transient_sets )
    {
        if ( index != var_20e7486efb53100d )
        {
            level.transient_sets[ index ] = 0;
        }
    }
    
    level.transient_sets[ var_20e7486efb53100d ] = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13078
// Size: 0x3f
function function_b919f3d6c1f1f825( var_20e7486efb53100d )
{
    /#
        function_64c8bf68f2b25ffe( var_20e7486efb53100d );
    #/
    
    if ( isdefined( level.transient_sets ) )
    {
        if ( isdefined( level.transient_sets[ var_20e7486efb53100d ] ) )
        {
            return level.transient_sets[ var_20e7486efb53100d ];
        }
    }
    
    return 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x130c0
// Size: 0x6c
function function_c42fe942fb416ae7()
{
    if ( isdefined( level.transient_sets ) )
    {
        foreach ( index, item in level.transient_sets )
        {
            if ( level.transient_sets[ index ] == 1 )
            {
                return index;
            }
        }
    }
    
    return undefined;
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x13135
    // Size: 0x78, Type: dev
    function private function_64c8bf68f2b25ffe( var_20e7486efb53100d )
    {
        names = gettransientsetnames();
        
        foreach ( name in names )
        {
            if ( name == var_20e7486efb53100d )
            {
                return 1;
            }
        }
        
        assertmsg( var_20e7486efb53100d + "<dev string:x4db>" );
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x131b5
// Size: 0x5d
function transient_load( name )
{
    if ( istransientloaded( name ) )
    {
        return;
    }
    
    if ( !flag_exist( name + "_loaded" ) )
    {
        flag_init( name + "_loaded" );
    }
    
    loadtransient( name );
    
    while ( !istransientloaded( name ) )
    {
        waitframe();
    }
    
    flag_set( name + "_loaded" );
    level notify( "new_transient_loaded" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1321a
// Size: 0x37
function transient_unload( name )
{
    if ( !istransientloaded( name ) )
    {
        return;
    }
    
    unloadtransient( name );
    
    while ( istransientloaded( name ) )
    {
        waitframe();
    }
    
    flag_clear( name + "_loaded" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13259
// Size: 0xc3
function transient_load_array( name_array )
{
    foreach ( name in name_array )
    {
        thread transient_load( name );
    }
    
    while ( true )
    {
        alldone = 1;
        
        foreach ( name in name_array )
        {
            if ( !istransientloaded( name ) )
            {
                alldone = 0;
                break;
            }
        }
        
        if ( alldone )
        {
            break;
        }
        
        waitframe();
    }
    
    level notify( "new_transient_loaded" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13324
// Size: 0xbb
function transient_unload_array( name_array )
{
    foreach ( name in name_array )
    {
        thread transient_unload( name );
    }
    
    while ( true )
    {
        alldone = 1;
        
        foreach ( name in name_array )
        {
            if ( istransientloaded( name ) )
            {
                alldone = 0;
                break;
            }
        }
        
        if ( alldone )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x133e7
// Size: 0x55
function function_17175f6af83bafea( name_array )
{
    foreach ( name in name_array )
    {
        settransientvisibility( name, 1 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13444
// Size: 0x54
function function_7dcc5e04ab79399b( name_array )
{
    foreach ( name in name_array )
    {
        settransientvisibility( name, 0 );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x134a0
// Size: 0x32
function transient_init( name )
{
    assertex( !isdefined( level.script ), "Can't create transients after load::main()" );
    flag_init( name + "_loaded" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x134da
// Size: 0x43
function transient_switch( prev, next )
{
    if ( flag( prev + "_loaded" ) )
    {
        transient_unload( prev );
    }
    
    if ( !flag( next + "_loaded" ) )
    {
        transient_load( next );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13525
// Size: 0x19
function transient_unloadall_and_load( name )
{
    unloadalltransients();
    transient_load( name );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x13546
// Size: 0x3cb
function follow_path_and_animate( start_node, require_player_dist )
{
    self endon( "death" );
    self endon( "stop_path" );
    self notify( "stop_going_to_node" );
    self notify( "follow_path" );
    self endon( "follow_path" );
    wait 0.1;
    node = start_node;
    getfunc = undefined;
    gotofunc = undefined;
    
    if ( !isdefined( require_player_dist ) )
    {
        require_player_dist = 300;
    }
    
    self.current_follow_path = node;
    node script_delay();
    
    while ( isdefined( node ) )
    {
        self.current_follow_path = node;
        
        if ( isdefined( node.lookahead ) )
        {
            break;
        }
        
        if ( isdefined( level.struct_class_names[ "targetname" ][ node.targetname ] ) )
        {
            gotofunc = &follow_path_animate_set_struct;
        }
        else if ( isdefined( node.classname ) )
        {
            gotofunc = &follow_path_animate_set_ent;
        }
        else
        {
            gotofunc = &follow_path_animate_set_node;
        }
        
        if ( isdefined( node.radius ) && node.radius != 0 )
        {
            self.goalradius = node.radius;
        }
        
        if ( self.goalradius < 16 )
        {
            self.goalradius = 16;
        }
        
        if ( isdefined( node.height ) && node.height != 0 )
        {
            self.goalheight = node.height;
        }
        
        original_goalradius = self.goalradius;
        self childthread [[ gotofunc ]]( node );
        
        if ( isdefined( node.animation ) )
        {
            node waittill( node.animation );
        }
        else
        {
            while ( true )
            {
                self waittill( "goal" );
                
                if ( distance( node.origin, self.origin ) < original_goalradius + 10 || self.team != "allies" )
                {
                    break;
                }
            }
        }
        
        node notify( "trigger", self );
        
        if ( isdefined( node.script_flag_set ) )
        {
            flag_set( node.script_flag_set );
        }
        
        if ( isdefined( node.script_parameters ) )
        {
            words = strtok( node.script_parameters, " " );
            
            for ( i = 0; i < words.size ; i++ )
            {
                if ( isdefined( level.custom_followpath_parameter_func ) )
                {
                    self [[ level.custom_followpath_parameter_func ]]( words[ i ], node );
                }
                
                if ( self.type == "dog" )
                {
                    continue;
                }
                
                switch ( words[ i ] )
                {
                    case #"hash_493b8f0ecdefe593":
                        enable_cqbwalk();
                        break;
                    case #"hash_4a90998c82aa254a":
                        disable_cqbwalk();
                        break;
                    case #"hash_9843391b4c654860":
                        self delete();
                        return;
                }
            }
        }
        
        if ( !isdefined( node.script_requires_player ) && require_player_dist > 0 && self.team == "allies" )
        {
            while ( isalive( level.player ) )
            {
                if ( follow_path_wait_for_player( node, require_player_dist ) )
                {
                    break;
                }
                
                if ( isdefined( node.animation ) )
                {
                    self.goalradius = original_goalradius;
                    self setgoalpos( self.origin );
                }
                
                wait 0.05;
            }
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        if ( isdefined( node.script_flag_wait ) )
        {
            flag_wait( node.script_flag_wait );
        }
        
        if ( isdefined( node.script_flag_waitopen ) )
        {
            flag_waitopen( node.script_flag_waitopen );
        }
        
        node script_delay();
        node = node get_target_ent();
    }
    
    self notify( "path_end_reached" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x13919
// Size: 0x158, Type: bool
function follow_path_wait_for_player( node, dist )
{
    if ( distance( level.player.origin, node.origin ) < distance( self.origin, node.origin ) )
    {
        return true;
    }
    
    vec = undefined;
    vec = anglestoforward( self.angles );
    vec2 = vectornormalize( level.player.origin - self.origin );
    
    if ( isdefined( node.target ) )
    {
        temp = get_target_ent( node.target );
        vec = vectornormalize( temp.origin - node.origin );
    }
    else if ( isdefined( node.angles ) )
    {
        vec = anglestoforward( node.angles );
    }
    else
    {
        vec = anglestoforward( self.angles );
    }
    
    if ( vectordot( vec, vec2 ) > 0 )
    {
        return true;
    }
    
    if ( distance( level.player.origin, self.origin ) < dist )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13a7a
// Size: 0xb7
function follow_path_animate_set_node( node )
{
    self notify( "follow_path_new_goal" );
    
    if ( isdefined( node.animation ) )
    {
        node scripts\sp\anim::anim_generic_reach( self, node.animation );
        self notify( "starting_anim", node.animation );
        
        if ( isdefined( node.script_parameters ) && issubstr( node.script_parameters, "gravity" ) )
        {
            node scripts\sp\anim::anim_generic_gravity( self, node.animation );
        }
        else
        {
            node scripts\common\anim::anim_generic_run( self, node.animation );
        }
        
        self setgoalpos( self.origin );
        return;
    }
    
    set_goal_node( node );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13b39
// Size: 0xb7
function follow_path_animate_set_ent( ent )
{
    self notify( "follow_path_new_goal" );
    
    if ( isdefined( ent.animation ) )
    {
        ent scripts\sp\anim::anim_generic_reach( self, ent.animation );
        self notify( "starting_anim", ent.animation );
        
        if ( isdefined( ent.script_parameters ) && issubstr( ent.script_parameters, "gravity" ) )
        {
            ent scripts\sp\anim::anim_generic_gravity( self, ent.animation );
        }
        else
        {
            ent scripts\common\anim::anim_generic_run( self, ent.animation );
        }
        
        self setgoalpos( self.origin );
        return;
    }
    
    set_goal_ent( ent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13bf8
// Size: 0xd9
function follow_path_animate_set_struct( struct )
{
    self notify( "follow_path_new_goal" );
    
    if ( isdefined( struct.animation ) )
    {
        struct scripts\sp\anim::anim_generic_reach( self, struct.animation );
        self notify( "starting_anim", struct.animation );
        disable_exits();
        
        if ( isdefined( struct.script_parameters ) && issubstr( struct.script_parameters, "gravity" ) )
        {
            struct scripts\sp\anim::anim_generic_gravity( self, struct.animation );
        }
        else
        {
            struct scripts\common\anim::anim_generic_run( self, struct.animation );
        }
        
        delaythread( 0.05, &enable_exits );
        self setgoalpos( self.origin );
        return;
    }
    
    set_goal_pos( struct.origin );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13cd9
// Size: 0x3b
function post_load_precache( function )
{
    if ( !isdefined( level.post_load_funcs ) )
    {
        level.post_load_funcs = [];
    }
    
    level.post_load_funcs = array_add( level.post_load_funcs, function );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13d1c
// Size: 0x36
function ui_action_slot_force_active_on( slot )
{
    dvarname = hashcat( @"hash_d0d5f7f6113a71e8", slot, "_forceActive" );
    setdvar( dvarname, "on" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13d5a
// Size: 0x36
function ui_action_slot_force_active_off( slot )
{
    dvarname = hashcat( @"hash_d0d5f7f6113a71e8", slot, "_forceActive" );
    setdvar( dvarname, "turn_off" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x13d98
// Size: 0x36
function ui_action_slot_force_active_one_time( slot )
{
    dvarname = hashcat( @"hash_d0d5f7f6113a71e8", slot, "_forceActive" );
    setdvar( dvarname, "onetime" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x13dd6
// Size: 0xa2
function init_waits()
{
    if ( !add_init_script( "waits", &init_waits ) )
    {
        return;
    }
    
    level.waits = spawnstruct();
    level.waits.wait_any_func_array = [];
    level.waits.run_func_after_wait_array = [];
    level.waits.run_call_after_wait_array = [];
    level.waits.run_noself_call_after_wait_array = [];
    level.waits.do_wait_endons_array = [];
    level.waits.abort_wait_any_func_array = [];
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x13e80
// Size: 0x35f
function set_start_location( val, guys )
{
    nodes = [];
    
    if ( isstring( val ) )
    {
        nodes = get_target_array( val );
    }
    else if ( isarray( val ) )
    {
        nodes = val;
    }
    
    if ( nodes.size == 0 )
    {
        return;
    }
    
    if ( !isarray( guys ) )
    {
        guys = [ guys ];
    }
    
    foreach ( guy in guys )
    {
        start_node = undefined;
        
        foreach ( node in nodes )
        {
            if ( !isdefined( node.angles ) )
            {
                node.angles = ( 0, 0, 0 );
            }
            
            if ( !isdefined( node.script_noteworthy ) )
            {
                continue;
            }
            
            if ( isdefined( node.taken ) )
            {
                continue;
            }
            
            if ( isplayer( guy ) )
            {
                if ( node.script_noteworthy == "player" )
                {
                    start_node = node;
                    break;
                }
                
                continue;
            }
            
            if ( isdefined( guy.script_noteworthy ) && guy.script_noteworthy == node.script_noteworthy )
            {
                start_node = node;
                break;
            }
        }
        
        if ( isdefined( start_node ) )
        {
            start_node.taken = 1;
            guy.start_node = start_node;
            
            if ( isai( guy ) )
            {
                guy setgoalpos( start_node.origin );
            }
            
            guy teleport_ent( start_node );
        }
    }
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy.start_node ) )
        {
            continue;
        }
        
        foreach ( node in nodes )
        {
            if ( !isdefined( node.taken ) )
            {
                node.taken = 1;
                guy.start_node = node;
                
                if ( isai( guy ) )
                {
                    guy setgoalpos( node.origin );
                }
                
                guy teleport_ent( node );
                break;
            }
        }
    }
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy.start_node ) )
        {
            guy.start_node = undefined;
        }
    }
    
    foreach ( node in nodes )
    {
        if ( isdefined( node.taken ) )
        {
            node.taken = undefined;
        }
    }
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 1
    // Checksum 0x0, Offset: 0x141e7
    // Size: 0x19, Type: dev
    function kleenex_popup( autosave )
    {
        println( "<dev string:x4f9>" );
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x14208
// Size: 0x25
function set_nvg_vision( vision, blendtime )
{
    level.player scripts\sp\nvg\nvg_player::set_nvg_vision_proc( vision, blendtime );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14235
// Size: 0x1c
function set_nvg_light( light )
{
    level.player scripts\sp\nvg\nvg_player::set_nvg_light_proc( light );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14259
// Size: 0x1c
function set_nvg_flir( enable )
{
    level.player scripts\sp\nvg\nvg_player::set_nvg_flir_proc( enable );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1427d
// Size: 0x42
function is_flir_vision_on()
{
    assertex( isplayer( self ), "checking flir state on a non-player" );
    
    if ( isdefined( self.nvg ) && self.nvg.flir )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x142c7
// Size: 0xa9
function player_gesture_combat( gesturename, lookatent )
{
    assertex( self == level.player, "player_gesture_force must be called on level.player!" );
    self endon( "death" );
    gestureplayed = 0;
    blendtime = undefined;
    canceltransition = 0;
    
    if ( level.player get_player_demeanor() == "safe" )
    {
        blendtime = 1;
        canceltransition = 1;
    }
    
    var_e3fc3c4ab75476a4 = 0;
    
    if ( isdefined( lookatent ) )
    {
        gestureplayed = self playgestureviewmodel( gesturename, lookatent, var_e3fc3c4ab75476a4, blendtime, undefined );
    }
    else
    {
        gestureplayed = self playgestureviewmodel( gesturename, undefined, var_e3fc3c4ab75476a4, blendtime, undefined );
    }
    
    return gestureplayed;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x14379
// Size: 0x51
function player_gesture_noncombat( gesturename, lookatent )
{
    assertex( self == level.player, "player_gesture_force must be called on level.player!" );
    self endon( "death" );
    
    if ( self isfiring() )
    {
        return 0;
    }
    
    if ( self isreloading() )
    {
        return 0;
    }
    
    return player_gesture_force( gesturename, lookatent );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x143d3
// Size: 0xcf
function player_gesture_force( gesturename, lookatent )
{
    assertex( self == level.player, "player_gesture_force must be called on level.player!" );
    self endon( "death" );
    gestureplayed = 0;
    blendtime = undefined;
    canceltransition = 0;
    
    if ( level.player get_player_demeanor() == "safe" )
    {
        blendtime = 0.2;
        canceltransition = 1;
    }
    
    if ( isdefined( lookatent ) && isent( lookatent ) )
    {
        gestureplayed = self forceplaygestureviewmodel( gesturename, lookatent, blendtime, undefined, undefined );
    }
    else
    {
        gestureplayed = self forceplaygestureviewmodel( gesturename, undefined, blendtime, undefined, undefined );
    }
    
    if ( gestureplayed )
    {
        thread scripts\sp\player\gestures::player_gestures_input_disable( gesturename, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "gesture" );
    }
    
    return gestureplayed;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x144ab
// Size: 0x36
function get_ai_group_count( aigroup )
{
    return level._ai_group[ aigroup ].spawnercount + level._ai_group[ aigroup ].aicount;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x144ea
// Size: 0x82
function get_ai_group_sentient_count( aigroup )
{
    level._ai_group[ aigroup ].ai = array_removedead_or_dying( level._ai_group[ aigroup ].ai );
    level._ai_group[ aigroup ].ai = array_removeundefined( level._ai_group[ aigroup ].ai );
    return level._ai_group[ aigroup ].aicount;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14575
// Size: 0x20
function get_ai_group_spawner_count( aigroup )
{
    return level._ai_group[ aigroup ].spawnercount;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1459e
// Size: 0x20
function get_ai_group_death_count( aigroup )
{
    return level._ai_group[ aigroup ].aideaths;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x145c7
// Size: 0x20
function get_ai_group_spawners( aigroup )
{
    return level._ai_group[ aigroup ].spawners;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x145f0
// Size: 0x82
function get_ai_group_ai( aigroup )
{
    level._ai_group[ aigroup ].ai = array_removedead_or_dying( level._ai_group[ aigroup ].ai );
    level._ai_group[ aigroup ].ai = array_removeundefined( level._ai_group[ aigroup ].ai );
    return level._ai_group[ aigroup ].ai;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1467b
// Size: 0x45
function waittill_ai_group_dead( aigroup )
{
    while ( level._ai_group[ aigroup ].aicount || level._ai_group[ aigroup ].spawnercount )
    {
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x146c8
// Size: 0x4c
function fx_playontag_safe( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    if ( !isdefined( self.fx_ticket_queue ) )
    {
        fx_regulate_init();
    }
    
    thread fx_playontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x1471c
// Size: 0xb8
function fx_playontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    if ( isdefined( end_note ) )
    {
        self endon( end_note );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    fx_regulate();
    
    /#
        if ( getdvarint( @"hash_4c2f239edafa91c9" ) )
        {
            print3d( self gettagorigin( tag ), "<dev string:x52f>" + tag + "<dev string:x535>" + fx, ( 0, 1, 0 ), 1, 0.7, 20 );
        }
    #/
    
    if ( !isdefined( var_a6d635ca3756e9d7 ) || !var_a6d635ca3756e9d7 )
    {
        test_tag( tag, fx );
    }
    
    playfxontag( getfx( fx ), self, tag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x147dc
// Size: 0x4c
function fx_stopontag_safe( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    if ( !isdefined( self.fx_ticket_queue ) )
    {
        fx_regulate_init();
    }
    
    thread fx_stopontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x14830
// Size: 0x1ca
function test_tag( tag, fx )
{
    if ( self.model == "" )
    {
        assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but the entities model is empty" );
    }
    
    if ( isai( self ) )
    {
        success = 0;
        models = [];
        
        if ( isdefined( self.headmodel ) && self.headmodel != "" )
        {
            models[ models.size ] = self.headmodel;
        }
        
        if ( isdefined( self.hatmodel ) && self.hatmodel != "" )
        {
            models[ models.size ] = self.hatmodel;
        }
        
        if ( !isnullweapon( self.weapon ) )
        {
            models[ models.size ] = getweaponmodel( self.weapon );
        }
        
        models[ models.size ] = self.model;
        
        foreach ( model in models )
        {
            if ( hastag( model, tag ) )
            {
                success = 1;
                break;
            }
        }
        
        if ( !success )
        {
            assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but tag <" + tag + "> does not exist in ai <" + self.model + ">" );
        }
        
        return;
    }
    
    if ( !hastag( self.model, tag ) )
    {
        assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but tag <" + tag + "> does not exist in model <" + self + ">" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x14a02
// Size: 0x72
function fx_stopontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    if ( isdefined( end_note ) )
    {
        self endon( end_note );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    fx_regulate();
    
    if ( !isdefined( var_a6d635ca3756e9d7 ) || !var_a6d635ca3756e9d7 )
    {
        test_tag( tag, fx );
    }
    
    stopfxontag( getfx( fx ), self, tag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x14a7c
// Size: 0x4c
function fx_killontag_safe( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    if ( !isdefined( self.fx_ticket_queue ) )
    {
        fx_regulate_init();
    }
    
    thread fx_killontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x14ad0
// Size: 0x9d
function fx_killontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    if ( isdefined( end_note ) )
    {
        self endon( end_note );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    fx_regulate();
    
    if ( !isdefined( var_a6d635ca3756e9d7 ) || !var_a6d635ca3756e9d7 )
    {
        test_tag( tag, fx );
    }
    
    if ( tag == "tag_flash" && isnullweapon( self.weapon ) )
    {
        println( "<dev string:x53b>" );
        return;
    }
    
    killfxontag( getfx( fx ), self, tag );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14b75
// Size: 0x1b
function get_fx_ticket()
{
    self.fx_ticket++;
    return string( self.fx_ticket );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14b99
// Size: 0x2c
function fx_regulate_init()
{
    if ( isdefined( self.fx_ticket_queue ) )
    {
        return;
    }
    
    self.fx_ticket_queue = [];
    self.fx_ticket = 0;
    thread fx_regulator();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14bcd
// Size: 0x7d
function fx_regulator()
{
    self endon( "entitydeleted" );
    i = 0;
    
    while ( true )
    {
        self waittill( "new_fx_call" );
        
        while ( self.fx_ticket_queue.size > 0 )
        {
            ticket = self.fx_ticket_queue[ 0 ];
            self.fx_ticket_queue = array_remove( self.fx_ticket_queue, ticket );
            self notify( ticket );
            i++;
            
            if ( i == 3 )
            {
                wait 0.05;
                i = 0;
            }
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14c52
// Size: 0x46
function fx_regulate()
{
    self endon( "death" );
    self endon( "entitydeleted" );
    ticket = get_fx_ticket();
    self.fx_ticket_queue = array_add( self.fx_ticket_queue, ticket );
    self notify( "new_fx_call" );
    self waittill( ticket );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14ca0
// Size: 0x43
function stop_player_gesture( gesture )
{
    assertex( self == level.player, "stop_player_gesture must be called on level.player!" );
    
    if ( isdefined( gesture ) )
    {
        self stopgestureviewmodel( gesture );
    }
    else
    {
        self stopgestureviewmodel();
    }
    
    self notify( "gesture_stop" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14ceb
// Size: 0xce
function set_player_demeanor( demeanorname )
{
    assertex( self == level.player, "set_player_demeanor must be called on level.player!" );
    self notify( "entering_new_demeanor" );
    
    if ( !isdefined( self.gestures ) )
    {
        self.gestures = spawnstruct();
    }
    
    waittillframeend();
    
    switch ( demeanorname )
    {
        case #"hash_dc5052e5ad5e04ee":
            scripts\sp\player\gestures::enter_demeanor_green_beam();
            break;
        case #"hash_84fcf5e68d7230b2":
            scripts\sp\player\gestures::enter_demeanor_normal();
            break;
        case #"hash_c95b4ea9bd7d7dfc":
            scripts\sp\player\gestures::enter_demeanor_relaxed();
            break;
        case #"hash_9682e089e580b4b8":
            scripts\sp\player\gestures::enter_demeanor_safe();
            break;
        default:
            assertmsg( "set_player_demeanor called with invalid demeanorName '" + demeanorname + "'!" );
            break;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14dc1
// Size: 0x10
function get_player_demeanor()
{
    return level.player getdemeanorviewmodel();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14dda
// Size: 0x39
function init_gravity()
{
    if ( !isdefined( level.gravity_gameplay ) )
    {
        level.gravity_gameplay = getdvarint( @"bg_gravity" );
        level.gravity_physics = getomnvar( "physics_gravity_z" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x14e1b
// Size: 0x52
function scale_gravity( gameplay_scale, physics_scale )
{
    init_gravity();
    
    if ( isdefined( gameplay_scale ) )
    {
        setsaveddvar( @"bg_gravity", level.gravity_gameplay * gameplay_scale );
    }
    
    if ( isdefined( physics_scale ) )
    {
        physics_setgravity( ( 0, 0, level.gravity_physics * physics_scale ) );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14e75
// Size: 0x4e
function atmosphere_enable( enable )
{
    if ( !isdefined( enable ) )
    {
        enable = 1;
    }
    
    if ( enable && !level.atmosphere )
    {
        level.atmosphere = enable;
        return;
    }
    
    if ( !enable && level.atmosphere )
    {
        level.atmosphere = enable;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x14ecb
// Size: 0x3e
function set_gravity( gameplay_gravity, physics_gravity )
{
    init_gravity();
    
    if ( isdefined( gameplay_gravity ) )
    {
        setsaveddvar( @"bg_gravity", gameplay_gravity );
    }
    
    if ( isdefined( physics_gravity ) )
    {
        physics_setgravity( ( 0, 0, physics_gravity ) );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x14f11
// Size: 0x2c
function reset_gravity()
{
    setsaveddvar( @"bg_gravity", level.gravity_gameplay );
    physics_setgravity( ( 0, 0, level.gravity_physics ) );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14f45
// Size: 0x3d
function gesture_stop( blendout_time )
{
    thread namespace_3123a12d1da4993::ai_gesture_eyes_stop( blendout_time * 0.1 );
    thread namespace_3123a12d1da4993::ai_gesture_stop( blendout_time );
    self notify( "stop_lookat" );
    self notify( "gesture_natural_stop" );
    self.playing_gesture = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14f8a
// Size: 0x14
function gesture_torso_stop( blendout_time )
{
    thread namespace_3123a12d1da4993::ai_gesture_torso_stop( blendout_time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14fa6
// Size: 0x14
function gesture_eyes_stop( blendout_time )
{
    thread namespace_3123a12d1da4993::ai_gesture_eyes_stop( blendout_time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x14fc2
// Size: 0x1b
function gesture_head_stop( blendout_time )
{
    namespace_3123a12d1da4993::ai_gesture_stop( blendout_time );
    self notify( "stop_lookat" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x14fe5
// Size: 0x2d
function gesture_follow_lookat( lookat_target, catchup_speed, blend_in_time )
{
    self endon( "death" );
    thread namespace_3123a12d1da4993::ai_gesture_lookat( lookat_target, catchup_speed, blend_in_time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x1501a
// Size: 0x2f
function gesture_follow_lookat_natural( lookat_target, catchup_speed, blend_in_time, check_range )
{
    thread namespace_3123a12d1da4993::ai_gesture_lookat_natural( lookat_target, catchup_speed, blend_in_time, check_range );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x15051
// Size: 0x26
function gesture_follow_eyes( lookat_target, catchup_speed, blend_in_time )
{
    thread namespace_3123a12d1da4993::ai_gesture_eyes_lookat( lookat_target, catchup_speed, blend_in_time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1507f
// Size: 0x1d
function gesture_follow_torso( lookat_target, blend_in_time )
{
    thread namespace_3123a12d1da4993::ai_gesture_lookat_torso( lookat_target, blend_in_time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x150a4
// Size: 0x1c
function gesture_follow_lookat_update( new_lookat, var_809d5bbb11b6031c )
{
    namespace_3123a12d1da4993::ai_gesture_update_lookat( new_lookat, var_809d5bbb11b6031c );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x150c8
// Size: 0x1c
function gesture_follow_eye_update( new_lookat, var_809d5bbb11b6031c )
{
    namespace_3123a12d1da4993::ai_gesture_update_eyes_lookat( new_lookat, var_809d5bbb11b6031c );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x150ec
// Size: 0x13
function gesture_point( pointat )
{
    namespace_3123a12d1da4993::ai_gesture_point( pointat );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15107
// Size: 0x13
function gesture_simple( var_7ca8d1ce367054f8 )
{
    namespace_3123a12d1da4993::ai_gesture_simple( var_7ca8d1ce367054f8 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x15122
// Size: 0x25
function gesture_directional_custom( target, anim_array, partial_bool )
{
    namespace_3123a12d1da4993::ai_gesture_directional_custom( target, anim_array, partial_bool );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1514f
// Size: 0x1c
function gesture_custom( gesture_anim, partial_bool )
{
    namespace_3123a12d1da4993::ai_custom_gesture( gesture_anim, partial_bool );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15173
// Size: 0x129
function gesture_eye_dart_loop( var_a9892a7cfb14ea8a, use_head )
{
    self endon( "death" );
    self endon( "stop_lookat" );
    self endon( "eye_gesture_stop" );
    
    if ( !isdefined( self.is_eye_tracking ) )
    {
        thread gesture_follow_eyes( var_a9892a7cfb14ea8a, 4, 0.1 );
    }
    
    if ( isdefined( use_head ) && use_head )
    {
        thread gesture_follow_lookat( var_a9892a7cfb14ea8a, 0.15, 0.7 );
    }
    
    wait 0.7;
    
    while ( true )
    {
        thread gesture_follow_eye_update( var_a9892a7cfb14ea8a, 2 );
        wait randomfloatrange( 3, 5 );
        random_target = var_a9892a7cfb14ea8a geteye() + ( randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ), randomfloatrange( -2, 2 ) );
        thread gesture_follow_eye_update( random_target, 2 );
        wait randomfloatrange( 0.25, 0.5 );
        
        if ( cointoss() )
        {
            random_target = var_a9892a7cfb14ea8a geteye() + ( randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ), randomfloatrange( -2, 2 ) );
            thread gesture_follow_eye_update( random_target, 2 );
            wait randomfloatrange( 0.25, 0.5 );
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x152a4
// Size: 0xeb
function gesture_simple_when_close( var_7ca8d1ce367054f8, dist, dist_target, optional_func )
{
    self endon( "death" );
    self endon( "gesture_stop" );
    dist_to = squared( dist );
    scripts\sp\interaction_manager::add_actor_to_manager();
    dist_from = distance2dsquared( self.origin, dist_target.origin );
    
    while ( true )
    {
        if ( dist_from < dist_to && scripts\sp\interaction_manager::can_play_nearby_gesture( dist * 3 ) )
        {
            break;
        }
        
        dist_from = distance2dsquared( self.origin, dist_target.origin );
        waitframe();
    }
    
    self.playing_gesture = 1;
    
    if ( isdefined( optional_func ) )
    {
        thread gesture_simple( var_7ca8d1ce367054f8 );
        self [[ optional_func ]]();
    }
    else
    {
        gesture_simple( var_7ca8d1ce367054f8 );
    }
    
    wait 2;
    scripts\sp\interaction_manager::remove_actor_from_manager();
    self.playing_gesture = 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x15397
// Size: 0xe7
function get_direction_value( viewerangles, viewerorigin, targetorigin )
{
    anglestopoint = vectortoangles( targetorigin - viewerorigin );
    angle = viewerangles[ 1 ] - anglestopoint[ 1 ];
    angle += 360;
    angle = int( angle ) % 360;
    
    if ( angle > 350 || angle < 10 )
    {
        direction = "8";
    }
    else if ( angle < 60 )
    {
        direction = "9";
    }
    else if ( angle < 120 )
    {
        direction = "6";
    }
    else if ( angle < 150 )
    {
        direction = "3";
    }
    else if ( angle < 210 )
    {
        direction = "2";
    }
    else if ( angle < 240 )
    {
        direction = "1";
    }
    else if ( angle < 300 )
    {
        direction = "4";
    }
    else
    {
        direction = "7";
    }
    
    return direction;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15487
// Size: 0x22
function give_melee_weapon( weapon )
{
    take_melee_weapon();
    self giveweapon( weapon );
    self assignweaponmeleeslot( weapon );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x154b1
// Size: 0x5f
function take_melee_weapon()
{
    meleeweapons = self.meleeweapons;
    
    foreach ( meleeweapon in meleeweapons )
    {
        self takeweapon( meleeweapon );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15518
// Size: 0xd1
function offhandprecache( var_d76d57a68de988cc )
{
    scripts\sp\equipment\offhands::init();
    offhandprecachefuncs = scripts\sp\equipment\offhands::offhandprecachefuncs();
    
    foreach ( offhand in var_d76d57a68de988cc )
    {
        if ( scripts\sp\equipment\offhands::offhandisprecached( offhand ) )
        {
            continue;
        }
        
        precacheitem( offhand );
        
        if ( array_contains_key( offhandprecachefuncs, offhand ) )
        {
            [[ offhandprecachefuncs[ offhand ] ]]( offhand );
        }
        else
        {
            assertmsg( "attempting to prechache offhand <" + offhand + "> that has no precache func in scriptsspequipmentoffhands::offhandPrecacheFuncs()" );
        }
        
        level.offhands.precached = array_add( level.offhands.precached, offhand );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x155f1
// Size: 0x3f
function give_offhand( weapon, var_1c7780cbd65c3c09, additional_attachments )
{
    if ( isplayer( self ) )
    {
        scripts\sp\player::offhandswap( weapon, var_1c7780cbd65c3c09, additional_attachments );
        return;
    }
    
    assertmsg( "give_offhand() should be called on player only" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15638
// Size: 0x2d
function take_offhand( weapon )
{
    if ( isplayer( self ) )
    {
        scripts\sp\player::offhandremove( weapon );
        return;
    }
    
    assertmsg( "give_offhand() should be called on player only" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1566d
// Size: 0x63
function get_melee_weapon()
{
    meleeweapons = self.meleeweapons;
    
    foreach ( meleeweapon in meleeweapons )
    {
        if ( !isnullweapon( meleeweapon ) )
        {
            return meleeweapon;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x156d9
// Size: 0x49
function give_action_slot_weapon( objweapon )
{
    assert( isweapon( objweapon ) );
    self.actionslotweapon = objweapon;
    self giveweapon( objweapon );
    
    if ( val::get( "action_slot_weapon" ) )
    {
        self setactionslot( 1, "weapon", objweapon );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1572a
// Size: 0x2a
function take_action_slot_weapon()
{
    self setactionslot( 1, "" );
    self takeweapon( self.actionslotweapon );
    self.actionslotweapon = undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1575c
// Size: 0x22
function get_action_slot_weapon()
{
    if ( isdefined( self.actionslotweapon ) )
    {
        return self.actionslotweapon;
    }
    
    return "";
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15786
// Size: 0xeb
function get_weapons_list_primaries( var_9b06efbc2fe3c5d6, includemeleeweapon )
{
    primaryweapons = level.player.primaryweapons;
    
    if ( isdefined( var_9b06efbc2fe3c5d6 ) && var_9b06efbc2fe3c5d6 == 1 )
    {
        primaryweapons = array_combine( primaryweapons, level.player.alternateweapons );
    }
    
    filteredweapons = [];
    meleeweapon = level.player get_melee_weapon();
    
    if ( isdefined( meleeweapon ) && ( !isdefined( includemeleeweapon ) || includemeleeweapon == 0 ) )
    {
        foreach ( weapon in primaryweapons )
        {
            if ( weapon != meleeweapon )
            {
                filteredweapons[ filteredweapons.size ] = weapon;
            }
        }
    }
    else
    {
        filteredweapons = primaryweapons;
    }
    
    return filteredweapons;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1587a
// Size: 0xd
function is_primary_equipment_button_down()
{
    return flag( "primary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15890
// Size: 0xe
function wait_primary_equipment_button_up()
{
    flag_waitopen( "primary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x158a6
// Size: 0xe
function wait_primary_equipment_button_down()
{
    flag_wait( "primary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x158bc
// Size: 0x16
function wait_primary_equipment_button_pressed()
{
    self waittill( "primary_equipment_pressed" );
    flag_wait( "primary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x158da
// Size: 0xd
function is_primary_equipment_in_use()
{
    return flag( "primary_equipment_in_use" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x158f0
// Size: 0xd
function is_secondary_equipment_button_down()
{
    return flag( "secondary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15906
// Size: 0xe
function wait_secondary_equipment_button_up()
{
    flag_waitopen( "secondary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1591c
// Size: 0xe
function wait_secondary_equipment_button_down()
{
    flag_wait( "secondary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15932
// Size: 0x16
function wait_secondary_equipment_button_pressed()
{
    self waittill( "secondary_equipment_pressed" );
    flag_wait( "secondary_equipment_input_down" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15950
// Size: 0xd
function is_secondary_equipment_in_use()
{
    return flag( "secondary_equipment_in_use" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15966
// Size: 0x3
function get_primary_equipment()
{
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15972
// Size: 0x3, Type: bool
function get_primary_equipment_ammo()
{
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1597e
// Size: 0x3
function get_secondary_equipment()
{
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1598a
// Size: 0x3, Type: bool
function get_secondary_equipment_ammo()
{
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15996
// Size: 0x3
function get_stored_primary_equipment()
{
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x159a2
// Size: 0x4, Type: bool
function get_stored_primary_equipment_ammo()
{
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x159af
// Size: 0x3
function get_stored_secondary_equipment()
{
    return undefined;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x159bb
// Size: 0x4, Type: bool
function get_stored_secondary_equipment_ammo()
{
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x159c8
// Size: 0xb2
function get_equipment_ammo( checkedequipment )
{
    equipmentfuncs = [ &get_primary_equipment, &get_stored_primary_equipment, &get_secondary_equipment, &get_stored_secondary_equipment ];
    ammofuncs = [ &get_primary_equipment_ammo, &get_stored_primary_equipment_ammo, &get_secondary_equipment_ammo, &get_stored_secondary_equipment_ammo ];
    
    for ( x = 0; x < equipmentfuncs.size ; x++ )
    {
        equipment = [[ equipmentfuncs[ x ] ]]();
        ammo = [[ ammofuncs[ x ] ]]();
        
        if ( isdefined( equipment ) && equipment == checkedequipment )
        {
            return ammo;
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15a82
// Size: 0x2d
function get_corpse_origin()
{
    if ( getdvarint( @"ai_corpsesynch" ) && isactorcorpse( self ) )
    {
        return self getcorpsephysicsorigin();
    }
    
    return self.origin;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x15ab8
// Size: 0x25
function hudoutline_add_channel( channelname, priority, hudoutlinesettings )
{
    scripts\sp\outline::hudoutline_add_channel_internal( channelname, priority, hudoutlinesettings );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x15ae5
// Size: 0x25
function hudoutline_add_child_channel( channelname, priority, parentchannelname )
{
    scripts\sp\outline::hudoutline_add_child_channel_internal( channelname, priority, parentchannelname );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15b12
// Size: 0x1c
function hudoutline_force_channel( channelname, shouldforce )
{
    scripts\sp\outline::hudoutline_force_channel_internal( channelname, shouldforce );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15b36
// Size: 0x1c
function hudoutline_enable_new( hudoutlineasset, channelname )
{
    scripts\sp\outline::hudoutline_enable_internal( channelname, hudoutlineasset );
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x15b5a
// Size: 0x30
function hudoutline_enable( color_index, depth_enable, fill_enable, channelname )
{
    scripts\sp\outline::hudoutline_enable_internal( channelname, "outline_depth_red" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15b92
// Size: 0x13
function hudoutline_disable( channelname )
{
    scripts\sp\outline::hudoutline_disable_internal( channelname );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15bad
// Size: 0x2e
function hudoutline_channel_animation( channelname, animationfunc )
{
    scripts\sp\outline::play_animation_on_channel( channelname, animationfunc );
    level notify( "hudoutline_anim_complete" );
    level notify( "hudoutline_anim_complete" + channelname );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15be3
// Size: 0x1d
function hudoutline_channel_animation_loop( channelname, animationfunc )
{
    thread scripts\sp\outline::play_animation_on_channel_loop( channelname, animationfunc );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15c08
// Size: 0x10e
function hudoutline_vis_enemy_settings( var_b4c5adb007bc6a66 )
{
    if ( !isdefined( var_b4c5adb007bc6a66 ) )
    {
        var_b4c5adb007bc6a66 = 1;
    }
    
    setsaveddvar( @"r_hudoutlineenable", 1 );
    fillcolor0 = "0.5 0.5 0.5";
    fillcolor1 = "1 1 1";
    
    if ( var_b4c5adb007bc6a66 )
    {
        fillcolor0 = "0.5 0.5 0.5 1";
        fillcolor1 = "0.5 0.5 0.5 0.2";
        occludedoutline = "0.5 0.5 0.5 1";
        occludedgraph = "0.7 0.7 0.7 1";
        occludedfill = "0.5 0.5 0.5 1";
    }
    else
    {
        fillcolor0 = "0.5 0.5 0.5 0";
        fillcolor1 = "0.5 0.5 0.5 0";
        occludedoutline = "0.5 0.5 0.5 1";
        occludedgraph = "0.5 0.5 0.5 0.5";
        occludedfill = "0.5 0.5 0.5 0.5";
    }
    
    setsaveddvar( @"r_hudoutlinefillcolor0", fillcolor0 );
    setsaveddvar( @"r_hudoutlinefillcolor1", fillcolor1 );
    setsaveddvar( @"r_hudoutlineoccludedoutlinecolor", occludedoutline );
    setsaveddvar( @"r_hudoutlineoccludedinlinecolor", occludedgraph );
    setsaveddvar( @"r_hudoutlineoccludedinteriorcolor", occludedfill );
    setsaveddvar( @"r_hudoutlineoccludedcolorfromfill", 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15d1e
// Size: 0xa7
function hudoutline_vis_enemy( enabled, forcedteam )
{
    team_type[ "allies" ] = "friendly";
    team_type[ "axis" ] = "enemy";
    team_type[ "team3" ] = "neutral";
    team_type[ "dead" ] = "neutral";
    
    if ( isdefined( forcedteam ) )
    {
        team = forcedteam;
    }
    else if ( isdefined( self.team ) )
    {
        team = self.team;
    }
    else
    {
        team = "dead";
    }
    
    if ( enabled && isdefined( team_type[ team ] ) )
    {
        set_hudoutline( team_type[ team ], 0 );
        return;
    }
    
    self hudoutlinedisable();
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x15dcd
// Size: 0x99
function hud_bink( bink_name )
{
    setomnvar( "ui_show_bink", 1 );
    setsaveddvar( @"bg_cinematicfullscreen", "0" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
    cinematicingame( bink_name );
    
    while ( !iscinematicplaying() )
    {
        waitframe();
    }
    
    while ( iscinematicplaying() )
    {
        waitframe();
    }
    
    stopcinematicingame();
    setomnvar( "ui_show_bink", 0 );
    setsaveddvar( @"bg_cinematicfullscreen", "1" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x15e6e
// Size: 0x40
function hud_fluff_text_message( display_text, context )
{
    if ( !isdefined( display_text ) )
    {
        display_text = "fluff_messages_default";
    }
    
    if ( !isdefined( context ) )
    {
        context = 1;
    }
    
    setomnvar( "ui_sp_fluff_messaging", display_text );
    setomnvar( "ui_sp_fluff_messaging_context", context );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15eb6
// Size: 0x3f
function _intel_waypoint_button_listener()
{
    level notify( "stopstop_intel_waypoint_int" );
    level endon( "stop_intel_waypoint" );
    self.intel_waypoint_request = undefined;
    self notifyonplayercommand( "set_waypoint", "+weapnext" );
    self waittill( "set_waypoint" );
    self.intel_waypoint_request = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15efd
// Size: 0x4f
function _intel_dismiss_button_listener()
{
    self endon( "dismiss_skipped" );
    self notifyonplayercommand( "intel_dismiss", "+gostand" );
    self notifyonplayercommand( "intel_dismiss", "+activate" );
    self notifyonplayercommand( "intel_dismiss", "+usereload" );
    self waittill( "intel_dismiss" );
    self.intel_dismiss_request = 1;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15f54
// Size: 0x29
function init_manipulate_ent()
{
    rotate_ents = getentarray( "manipulate_ent", "script_noteworthy" );
    array_thread( rotate_ents, &manipulate_ent_setup );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x15f85
// Size: 0x20e
function manipulate_ent_setup()
{
    if ( isdefined( self.script_flag_wait ) )
    {
        flag_init( self.script_flag_wait );
    }
    
    if ( isdefined( self.script_flag_waitopen ) )
    {
        flag_init( self.script_flag_waitopen );
    }
    
    if ( isdefined( self.script_deathflag ) )
    {
        flag_init( self.script_deathflag );
    }
    
    if ( isdefined( self.script_rotation_speed ) )
    {
        self.start_angles = self.angles;
        
        if ( !isdefined( self.script_rotation_max ) )
        {
            self.script_rotation_max = ( 0, 0, 0 );
        }
        
        self.rotation_spring_index = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( self.script_rotation_max[ i ] != 0 )
            {
                if ( self.script_rotation_speed[ i ] > 0 )
                {
                    self.rotation_spring_index[ i ] = math::spring_make_under_damped( self.script_rotation_speed[ i ] * 10, 0, self.start_angles[ i ] + self.script_rotation_max[ i ], 0 );
                    continue;
                }
                
                assertmsg( "A manipulate_ent that has a script_rotation_max must also have a script_rotation_speed greater than 0" );
            }
        }
        
        thread rotate_ent_think();
    }
    
    if ( isdefined( self.script_translate_speed ) )
    {
        self.start_origin = self.origin;
        
        if ( !isdefined( self.script_translate_max ) )
        {
            self.script_translate_max = ( 0, 0, 0 );
        }
        
        self.translate_spring_index = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( self.script_translate_max[ i ] != 0 )
            {
                if ( self.script_translate_speed[ i ] > 0 )
                {
                    self.translate_spring_index[ i ] = math::spring_make_under_damped( self.script_translate_speed[ i ] * 10, 0, self.start_origin[ i ] + self.script_translate_max[ i ], 0 );
                    continue;
                }
                
                assertmsg( "A manipulate_ent that has a script_translate_max must also have a script_translate_speed greater than 0" );
            }
        }
        
        thread translate_ent_think();
    }
    
    thread manipulate_ent_death_think();
    thread manipulate_ent_cleanup();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1619b
// Size: 0x132
function translate_ent_think()
{
    self endon( "death" );
    self endon( "stop_manipulate_ent" );
    
    if ( isdefined( self.script_flag_wait ) )
    {
        flag_wait( self.script_flag_wait );
    }
    
    if ( isdefined( self.script_flag_waitopen ) )
    {
        flag_waitopen( self.script_flag_waitopen );
    }
    
    while ( true )
    {
        new_origin = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( self.script_translate_speed[ i ] == 0 )
            {
                new_origin[ i ] = self.start_origin[ i ];
                continue;
            }
            
            if ( self.script_translate_speed[ i ] != 0 && self.script_translate_max[ i ] == 0 )
            {
                new_origin[ i ] = self.origin[ i ] + self.script_translate_speed[ i ] / 20;
                continue;
            }
            
            if ( self.script_translate_speed[ i ] > 0 && self.script_translate_max[ i ] != 0 )
            {
                new_origin[ i ] = math::spring_update( self.translate_spring_index[ i ], self.start_origin[ i ] );
            }
        }
        
        self.origin = ( new_origin[ 0 ], new_origin[ 1 ], new_origin[ 2 ] );
        waitframe();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x162d5
// Size: 0x144
function rotate_ent_think()
{
    self endon( "death" );
    self endon( "stop_manipulate_ent" );
    
    if ( isdefined( self.script_flag_wait ) )
    {
        flag_wait( self.script_flag_wait );
    }
    
    if ( isdefined( self.script_flag_waitopen ) )
    {
        flag_waitopen( self.script_flag_waitopen );
    }
    
    while ( true )
    {
        new_angle = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( self.script_rotation_speed[ i ] == 0 )
            {
                new_angle[ i ] = self.start_angles[ i ];
                continue;
            }
            
            if ( self.script_rotation_speed[ i ] != 0 && self.script_rotation_max[ i ] == 0 )
            {
                new_angle[ i ] = self.angles[ i ] + self.script_rotation_speed[ i ] / 20;
                continue;
            }
            
            if ( self.script_rotation_speed[ i ] > 0 && self.script_rotation_max[ i ] != 0 )
            {
                new_angle[ i ] = math::spring_update( self.rotation_spring_index[ i ], self.start_angles[ i ] );
            }
        }
        
        new_angle = ( angleclamp( new_angle[ 0 ] ), angleclamp( new_angle[ 1 ] ), angleclamp( new_angle[ 2 ] ) );
        self.angles = new_angle;
        waitframe();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x16421
// Size: 0x52
function manipulate_ent_death_think()
{
    self endon( "death" );
    
    if ( isdefined( self.script_deathflag ) )
    {
        flag_wait( self.script_deathflag );
        
        if ( isdefined( self.script_delete ) && self.script_delete )
        {
            self delete();
            return;
        }
        
        self notify( "stop_manipulate_ent" );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1647b
// Size: 0xc6
function manipulate_ent_cleanup()
{
    waittill_either( "death", "stop_manipulate_ent" );
    
    if ( isdefined( self.rotation_spring_index ) )
    {
        foreach ( spring_index in self.rotation_spring_index )
        {
            math::spring_delete( spring_index );
        }
    }
    
    if ( isdefined( self.translate_spring_index ) )
    {
        foreach ( spring_index in self.translate_spring_index )
        {
            math::spring_delete( spring_index );
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x16549
// Size: 0x3d
function strip_suffix( lookupstring, stripstring )
{
    if ( lookupstring.size <= stripstring.size )
    {
        return lookupstring;
    }
    
    if ( getsubstr( lookupstring, lookupstring.size - stripstring.size, lookupstring.size ) == stripstring )
    {
        return getsubstr( lookupstring, 0, lookupstring.size - stripstring.size );
    }
    
    return lookupstring;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1658f
// Size: 0x35
function set_exception( type, func )
{
    assert( isdefined( self.exception[ type ] ) );
    self.exception[ type ] = func;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x165cc
// Size: 0x4c
function set_all_exceptions( exceptionfunc )
{
    keys = getarraykeys( self.exception );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        self.exception[ keys[ i ] ] = exceptionfunc;
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 8
// Checksum 0x0, Offset: 0x16620
// Size: 0x136
function waittill_multiple_ents( ent1, string1, ent2, string2, ent3, string3, ent4, string4 )
{
    self endon( "death" );
    ent = spawnstruct();
    ent.threads = 0;
    
    if ( isdefined( ent1 ) )
    {
        assert( isdefined( string1 ) );
        ent1 childthread waittill_string( string1, ent );
        ent.threads++;
    }
    
    if ( isdefined( ent2 ) )
    {
        assert( isdefined( string2 ) );
        ent2 childthread waittill_string( string2, ent );
        ent.threads++;
    }
    
    if ( isdefined( ent3 ) )
    {
        assert( isdefined( string3 ) );
        ent3 childthread waittill_string( string3, ent );
        ent.threads++;
    }
    
    if ( isdefined( ent4 ) )
    {
        assert( isdefined( string4 ) );
        ent4 childthread waittill_string( string4, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( "returned" );
        ent.threads--;
    }
    
    ent notify( "die" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x1675e
// Size: 0x7b
function get_linked_scriptables()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            return getscriptablearray( linknames[ 0 ], "script_linkname" );
        }
        else if ( linknames.size > 1 )
        {
            return getscriptablesfromvalues( linknames, "script_linkname" );
        }
    }
    
    if ( !array.size && gettime() <= 300 )
    {
        assertmsg( "Scriptables are not initialized immediately - do you need to wait until they're initialized?" );
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x167e2
// Size: 0xde
function get_linked_vehicles()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        allvehicles = vehicle_getarray();
        
        foreach ( vehicle in allvehicles )
        {
            foreach ( name in linknames )
            {
                if ( is_equal( vehicle.script_linkname, name ) )
                {
                    array[ array.size ] = vehicle;
                }
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x168c9
// Size: 0xde
function get_linked_vehicle_spawners()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        spawners = vehicle_getspawnerarray();
        
        foreach ( spawner in spawners )
        {
            foreach ( name in linknames )
            {
                if ( is_equal( spawner.script_linkname, name ) )
                {
                    array[ array.size ] = spawner;
                }
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x169b0
// Size: 0xde
function get_linked_spawners()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        allspawners = getspawnerarray();
        
        foreach ( spawner in allspawners )
        {
            foreach ( name in linknames )
            {
                if ( is_equal( spawner.script_linkname, name ) )
                {
                    array[ array.size ] = spawner;
                }
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x16a97
// Size: 0x5a
function get_linked_vehicle_nodes()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            return getvehiclenodearray( linknames[ 0 ], "script_linkname" );
        }
        else if ( linknames.size > 1 )
        {
            return function_df5a62cb94a82870( linknames, "script_linkname" );
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x16afa
// Size: 0x134
function run_thread_on_targetname( msg, func, param1, param2, param3 )
{
    array = getentarray( msg, "targetname" );
    array_thread( array, func, param1, param2, param3 );
    
    if ( isdefined( level.getspawnerarrayfunction ) )
    {
        all = builtin [[ level.getspawnerarrayfunction ]]( msg );
        
        foreach ( s in all )
        {
            if ( isnonentspawner( s ) )
            {
                array_thread( [ s ], func, param1, param2, param3 );
            }
        }
    }
    
    array = getstructarray( msg, "targetname" );
    array_thread( array, func, param1, param2, param3 );
    array = builtin [[ level.getnodearrayfunction ]]( msg, "targetname" );
    array_thread( array, func, param1, param2, param3 );
    array = getvehiclenodearray( msg, "targetname" );
    array_thread( array, func, param1, param2, param3 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x16c36
// Size: 0x154
function run_thread_on_noteworthy( msg, func, param1, param2, param3 )
{
    array = getentarray( msg, "script_noteworthy" );
    array_thread( array, func, param1, param2, param3 );
    
    if ( isdefined( level.getspawnerarrayfunction ) )
    {
        all = builtin [[ level.getspawnerarrayfunction ]]();
        
        foreach ( s in all )
        {
            if ( isdefined( s.script_noteworthy ) && s.script_noteworthy == msg && isnonentspawner( s ) )
            {
                array_thread( [ s ], func, param1, param2, param3 );
            }
        }
    }
    
    array = getstructarray( msg, "script_noteworthy" );
    array_thread( array, func, param1, param2, param3 );
    array = builtin [[ level.getnodearrayfunction ]]( msg, "script_noteworthy" );
    array_thread( array, func, param1, param2, param3 );
    array = getvehiclenodearray( msg, "script_noteworthy" );
    array_thread( array, func, param1, param2, param3 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x16d92
// Size: 0x9b
function get_noteworthy_ent( noteworthy )
{
    assertex( isdefined( noteworthy ), "No script_noteworthy provided!" );
    ent = getent( noteworthy, "script_noteworthy" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    if ( issp() )
    {
        ent = builtin [[ level.getnodefunction ]]( noteworthy, "script_noteworthy" );
        
        if ( isdefined( ent ) )
        {
            return ent;
        }
    }
    
    ent = getstruct( noteworthy, "script_noteworthy" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    ent = getvehiclenode( noteworthy, "script_noteworthy" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    assertex( "Tried to get a ent by noteworthy \"" + noteworthy + "\" but none were found." );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x16e35
// Size: 0x60, Type: bool
function is_locked( msg )
{
    assert( isdefined( level.lock ) );
    assert( isdefined( level.lock[ msg ] ) );
    lock = level.lock[ msg ];
    return lock.count > lock.max_count;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x16e9e
// Size: 0xb7
function getfarthest( org, array, maxdist )
{
    if ( !isdefined( maxdist ) )
    {
        maxdist = 500000;
    }
    
    dist = 0;
    ent = undefined;
    
    foreach ( item in array )
    {
        newdist = distance( item.origin, org );
        
        if ( newdist <= dist || newdist >= maxdist )
        {
            continue;
        }
        
        dist = newdist;
        ent = item;
    }
    
    return ent;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x16f5e
// Size: 0x96
function array_sort_by_handler( array, compare_func )
{
    assertex( isdefined( array ), "Array not defined." );
    assertex( isdefined( compare_func ), "Compare function not defined." );
    
    for ( i = 0; i < array.size - 1 ; i++ )
    {
        for ( j = i + 1; j < array.size ; j++ )
        {
            if ( array[ j ] [[ compare_func ]]() < array[ i ] [[ compare_func ]]() )
            {
                ref = array[ j ];
                array[ j ] = array[ i ];
                array[ i ] = ref;
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x16ffd
// Size: 0xd8
function monitor_interact_delay( interact, forcedstance )
{
    interact waittill( "trigger", who );
    level.player enableslowaim( 0.1, 0.1 );
    level.player val::set( "monitor_interact_delay", "ads", 0 );
    
    while ( !level.player isonground() )
    {
        wait 0.05;
    }
    
    currentstance = level.player getstance();
    
    if ( currentstance != forcedstance )
    {
        level.player setstance( forcedstance );
        
        if ( currentstance == "prone" )
        {
            wait 0.2;
        }
    }
    
    level.player disableslowaim();
    level.player val::reset_all( "monitor_interact_delay" );
    return who;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x170de
// Size: 0x81
function ai_create_weapon_stow( weapon )
{
    self.weapon_stow = spawn( "script_model", self gettagorigin( "tag_stowed_back" ) );
    self.weapon_stow setmodel( getweaponmodel( weapon ) );
    self.weapon_stow notsolid();
    self.weapon_stow.angles = self gettagangles( "tag_stowed_back" );
    self.weapon_stow linkto( self, "tag_stowed_back" );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x17167
// Size: 0x4e
function countdown_start( time, message )
{
    level notify( "countdown_start" );
    level endon( "countdown_start" );
    level endon( "countdown_end" );
    setomnvar( "ui_countdown_mission_text", message );
    setomnvar( "ui_countdown_timer", gettime() + time * 1000 * 60 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x171bd
// Size: 0x16
function countdown_end()
{
    level notify( "countdown_end" );
    setomnvar( "ui_countdown_timer", 0 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x171db
// Size: 0x1f
function setfirstsavetime( time )
{
    time = max( time, 2 );
    level.beginningoflevelsavedelay = time;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x17202
// Size: 0x39
function motion_blur_disable( time )
{
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    thread lerp_saveddvar( @"hash_ea4c44a08cd23d5d", 0, time );
    thread lerp_saveddvar( @"hash_c7590c5a3289a2d", 0, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x17243
// Size: 0xb1
function motion_blur_enable( velocityscale, velocityscaleviewmodel, time )
{
    if ( !isdefined( velocityscale ) )
    {
        velocityscale = ter_op( isdefined( level.motionblur ), level.motionblur[ "velocityScaleDefault" ], getdvarfloat( @"hash_ea4c44a08cd23d5d" ) );
    }
    
    if ( !isdefined( velocityscaleviewmodel ) )
    {
        velocityscaleviewmodel = ter_op( isdefined( level.motionblur ), level.motionblur[ "velocityScaleViewModelDefault" ], getdvarfloat( @"hash_c7590c5a3289a2d" ) );
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    thread lerp_saveddvar( @"hash_ea4c44a08cd23d5d", velocityscale, time );
    thread lerp_saveddvar( @"hash_c7590c5a3289a2d", velocityscaleviewmodel, time );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x172fc
// Size: 0x69
function create_motion_blur_defaults( velocityscale, velocityscaleviewmodel )
{
    if ( !isdefined( velocityscale ) )
    {
        velocityscale = getdvarfloat( @"hash_ea4c44a08cd23d5d" );
    }
    
    if ( !isdefined( velocityscaleviewmodel ) )
    {
        velocityscaleviewmodel = getdvarfloat( @"hash_c7590c5a3289a2d" );
    }
    
    level.motionblur = [];
    level.motionblur[ "velocityScaleDefault" ] = velocityscale;
    level.motionblur[ "velocityScaleViewModelDefault" ] = velocityscaleviewmodel;
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x1736d
// Size: 0x6b
function actionslotoverride( actionslot, material, ammocount, function, var_96a185efc1665bec )
{
    self setweaponhudiconoverride( "actionslot" + actionslot, material );
    
    if ( isdefined( ammocount ) )
    {
        setactionslotoverrideammo( actionslot, ammocount );
    }
    
    if ( isdefined( function ) )
    {
        thread actionslotoverridecallback( actionslot, function, var_96a185efc1665bec );
    }
    
    level.player thread scripts\sp\player::allow_player_weapon_info( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x173e0
// Size: 0x93
function actionslotoverridecallback( actionslot, function, var_96a185efc1665bec )
{
    self endon( "death" );
    self endon( "removeActionslot" + actionslot );
    self notifyonplayercommand( "actionslot" + actionslot, "+" + "actionslot " + actionslot );
    
    while ( true )
    {
        self waittill( "actionslot" + actionslot );
        
        if ( !isdefined( var_96a185efc1665bec ) || !var_96a185efc1665bec || var_96a185efc1665bec && level.player usinggamepad() )
        {
            level.player thread scripts\sp\player::allow_player_weapon_info( 1 );
            self thread [[ function ]]();
        }
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1747b
// Size: 0x4b
function actionslotoverrideremove( actionslot )
{
    self notify( "removeActionslot" + actionslot );
    self setweaponhudiconoverrideammo( "actionslot" + actionslot, -1 );
    self setweaponhudiconoverride( "actionslot" + actionslot, "none" );
    level.player thread scripts\sp\player::allow_player_weapon_info( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x174ce
// Size: 0x56
function setactionslotoverrideammo( actionslot, ammocount )
{
    assertex( self getweaponhudiconoverride( "actionslot" + actionslot ) != "none", "SetActionSlotOverrideAmmo() set on actionslot that has not been overrided with ActionSlotOverride()" );
    self setweaponhudiconoverrideammo( "actionslot" + actionslot, ammocount );
    level.player thread scripts\sp\player::allow_player_weapon_info( 1 );
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1752c
// Size: 0x4b
function function_6078d3c20d55c620( excludemelee, var_71d55740c12bb86c )
{
    if ( !isdefined( excludemelee ) )
    {
        excludemelee = 0;
    }
    
    if ( !isdefined( var_71d55740c12bb86c ) )
    {
        var_71d55740c12bb86c = 0;
    }
    
    self takeallweapons( excludemelee, var_71d55740c12bb86c );
    
    if ( isdefined( self.climbfists ) )
    {
        scripts\sp\utility::give_weapon( self.climbfists );
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1757f
// Size: 0x13
function giveweaponmaxammo( weapon )
{
    self givemaxammo( weapon );
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x1759a
// Size: 0xcb, Type: bool
function can_trace_to_player( start, ignorearray, contentoverride )
{
    if ( !isdefined( ignorearray ) )
    {
        ignorearray = [];
    }
    
    if ( !isarray( ignorearray ) )
    {
        ignorearray = [ ignorearray ];
    }
    
    ignorearray[ ignorearray.size ] = level.player;
    
    if ( isent( self ) || isai( self ) )
    {
        ignorearray[ ignorearray.size ] = self;
    }
    
    if ( scripts\engine\trace::ray_trace_passed( start, level.player.origin, ignorearray, contentoverride ) )
    {
        return true;
    }
    
    if ( scripts\engine\trace::ray_trace_passed( start, level.player.origin + ( 0, 0, 30 ), ignorearray, contentoverride ) )
    {
        return true;
    }
    
    if ( scripts\engine\trace::ray_trace_passed( start, level.player geteye(), ignorearray, contentoverride ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 3
// Checksum 0x0, Offset: 0x1766e
// Size: 0x53
function function_4f6cdffaa41ad3d1( surface, actiontype, movetype )
{
    if ( is_dead_sentient() )
    {
        return;
    }
    
    if ( !isdefined( surface ) )
    {
        surface = "dirt";
    }
    
    if ( !isdefined( actiontype ) )
    {
        actiontype = "step";
    }
    
    if ( !isdefined( movetype ) )
    {
        movetype = "run";
    }
    
    self triggerfootstepevents( surface, actiontype, movetype );
}

/#

    // Namespace utility / scripts\engine\sp\utility
    // Params 2
    // Checksum 0x0, Offset: 0x176c9
    // Size: 0x21, Type: dev
    function play_footstep_sound( alias, surface )
    {
        println( "<dev string:x582>" );
    }

#/

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x176f2
// Size: 0x30, Type: bool
function wait_for_sounddone_or_death( org, other )
{
    if ( isdefined( other ) )
    {
        other endon( "death" );
    }
    
    self endon( "death" );
    org waittill( "sounddone" );
    return true;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x1772b
// Size: 0x3b
function delete_on_death_wait_sound( ent, sounddone )
{
    ent endon( "death" );
    self waittill( "death" );
    
    if ( isdefined( ent ) )
    {
        if ( ent iswaitingonsound() )
        {
            ent waittill( sounddone );
        }
        
        ent delete();
    }
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x1776e
// Size: 0x5a, Type: bool
function is_touching_any( array )
{
    foreach ( item in array )
    {
        if ( self istouching( item ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\sp\utility
// Params 2
// Checksum 0x0, Offset: 0x177d1
// Size: 0x1d
function scripter_note( str, duration )
{
    thread scripter_note_proc( str, duration );
}

// Namespace utility / scripts\engine\sp\utility
// Params 5
// Checksum 0x0, Offset: 0x177f6
// Size: 0x17b
function play_sound_on_tag( alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog )
{
    if ( is_dead_sentient() )
    {
        return;
    }
    
    org = spawn( "script_origin", self.origin );
    org endon( "death" );
    thread delete_on_death_wait_sound( org, "sounddone" );
    
    if ( isdefined( tag ) )
    {
        org linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    /#
        if ( isdefined( level.player_radio_emitter ) && self == level.player_radio_emitter )
        {
            println( "<dev string:x5f3>" + alias );
        }
        
        if ( getdvarint( @"hash_b95e70dfa43a9845" ) && !soundexists( alias ) )
        {
            println( "<dev string:x612>" + alias + "<dev string:x62b>" );
            org delete();
            return;
        }
    #/
    
    org playsound( alias, "sounddone" );
    
    if ( isdefined( ends_on_death ) )
    {
        assertex( ends_on_death, "ends_on_death must be true or undefined" );
        
        if ( !isdefined( wait_for_sounddone_or_death( org ) ) )
        {
            org stopsounds();
        }
        
        wait 0.05;
    }
    else
    {
        org waittill( "sounddone" );
    }
    
    if ( isdefined( var_b426f32755673ba6 ) )
    {
        self notify( var_b426f32755673ba6 );
    }
    
    org delete();
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x17979
// Size: 0x32
function setupglobalcallbackfunctions_sp()
{
    if ( !add_init_script( "globalCallbacks_SP", &setupglobalcallbackfunctions_sp ) )
    {
        return;
    }
    
    level.fnplaysoundonentity = &play_sound_on_entity;
    level.fnplaysoundontag = &play_sound_on_tag;
}

// Namespace utility / scripts\engine\sp\utility
// Params 1
// Checksum 0x0, Offset: 0x179b3
// Size: 0x17
function function_1ae8f046dee579e0( bool )
{
    setomnvar( "ui_cutscene_active", bool );
}

// Namespace utility / scripts\engine\sp\utility
// Params 0
// Checksum 0x0, Offset: 0x179d2
// Size: 0xe, Type: bool
function function_63171981a45b3ad8()
{
    return getomnvar( "ui_cutscene_active" ) > 0;
}

// Namespace utility / scripts\engine\sp\utility
// Params 4
// Checksum 0x0, Offset: 0x179e9
// Size: 0x6a
function fake_bullet( endpoint, weaponname, muzzleflash, muzzleflashtag )
{
    bullettracer( self.origin, endpoint, weaponname, 0 );
    self playweaponfiresound( weaponname );
    
    if ( isdefined( muzzleflash ) )
    {
        tagname = isdefined( muzzleflashtag ) ? muzzleflashtag : "tag_origin";
        playfxontag( getfx( muzzleflash ), self, tagname );
    }
}

