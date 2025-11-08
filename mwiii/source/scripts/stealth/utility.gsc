#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\friendly;
#using scripts\stealth\init;
#using scripts\stealth\manager;
#using scripts\stealth\neutral;
#using scripts\stealth\threat_sight;

#namespace utility;

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x261
// Size: 0x59
function get_group( name )
{
    if ( !isdefined( level.stealth.groupdata.groups[ name ] ) )
    {
        return undefined;
    }
    
    return level.stealth.groupdata.groups[ name ].members;
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x2c3
// Size: 0xe3
function group_flag_clear( f, group )
{
    name = get_group_flagname( f, group );
    flag_clear( name );
    array = level.stealth.group.flags[ f ];
    clear = 1;
    
    foreach ( value in array )
    {
        if ( !issubstr( value, "allies" ) && flag( value ) )
        {
            return;
        }
    }
    
    if ( flag( name ) && self != level )
    {
        self notify( f );
    }
    
    flag_clear( f );
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x3ae
// Size: 0x58
function group_flag_set( f )
{
    assertex( issentient( self ), "<dev string:x1c>" );
    name = get_group_flagname( f );
    
    if ( !flag( name ) && self != level )
    {
        self notify( f );
    }
    
    flag_set( name );
    flag_set( f );
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x40e
// Size: 0x39
function group_flag( f )
{
    assertex( issentient( self ), "<dev string:x1c>" );
    name = get_group_flagname( f );
    return flag( name );
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x450
// Size: 0x4d
function get_group_flagname( f, group )
{
    if ( !isdefined( group ) )
    {
        assertex( issentient( self ), "<dev string:x1c>" );
        group = self.script_stealthgroup;
    }
    
    name = f + "-Group:" + group;
    return name;
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x4a6
// Size: 0x26
function group_flag_wait( f )
{
    name = get_group_flagname( f );
    flag_wait( name );
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x4d4
// Size: 0x26
function group_flag_waitopen( f )
{
    name = get_group_flagname( f );
    flag_waitopen( name );
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x502
// Size: 0x2f
function group_flag_wait_or_timeout( f, timer )
{
    name = get_group_flagname( f );
    flag_wait_or_timeout( name, timer );
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x539
// Size: 0x2f
function group_flag_waitopen_or_timeout( f, timer )
{
    name = get_group_flagname( f );
    flag_waitopen_or_timeout( name, timer );
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x570
// Size: 0x147
function group_flag_init( f )
{
    assertex( issentient( self ), "<dev string:x1c>" );
    
    if ( isdefined( self.script_stealthgroup ) )
    {
        self.script_stealthgroup = string( self.script_stealthgroup );
    }
    else
    {
        self.script_stealthgroup = "default";
    }
    
    if ( !ismp() && self.team == "allies" )
    {
        self.script_stealthgroup += "allies";
    }
    
    if ( !flag_exist( f ) )
    {
        flag_init( f );
    }
    
    name = get_group_flagname( f );
    
    if ( !flag_exist( name ) )
    {
        flag_init( name );
        
        if ( !isdefined( level.stealth.group.flags[ f ] ) )
        {
            level.stealth.group.flags[ f ] = [];
        }
        
        level.stealth.group.flags[ f ][ level.stealth.group.flags[ f ].size ] = name;
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x6bf
// Size: 0x69
function group_setcombatgoalradius( group, goalradius )
{
    assert( isdefined( level.stealth ) );
    
    if ( !isdefined( level.stealth.combat_goalradius ) )
    {
        level.stealth.combat_goalradius = [];
    }
    
    level.stealth.combat_goalradius[ group ] = goalradius;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x730
// Size: 0xda
function group_add()
{
    assertex( issentient( self ), "<dev string:x1c>" );
    
    if ( !isdefined( level.stealth.group.groups[ self.script_stealthgroup ] ) )
    {
        level.stealth.group.groups[ self.script_stealthgroup ] = [];
        level.stealth.group notify( self.script_stealthgroup );
    }
    
    level.stealth.group.groups[ self.script_stealthgroup ][ level.stealth.group.groups[ self.script_stealthgroup ].size ] = self;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x812
// Size: 0x46
function group_spotted_flag()
{
    if ( !ismp() )
    {
        assert( self.team != "<dev string:x3d>", "<dev string:x45>" );
    }
    
    name = get_group_flagname( "stealth_spotted" );
    return flag( name );
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x861
// Size: 0x17
function any_groups_in_combat()
{
    if ( !flag( "stealth_enabled" ) )
    {
        return 0;
    }
    
    return stealthgetanyaiincombat();
}

/#

    // Namespace utility / scripts\stealth\utility
    // Params 0
    // Checksum 0x0, Offset: 0x881
    // Size: 0x24, Type: dev
    function check_stealth()
    {
        assertex( isdefined( self.stealth ), "<dev string:x77>" + self.origin );
    }

#/

// Namespace utility / scripts\stealth\utility
// Params 3
// Checksum 0x0, Offset: 0x8ad
// Size: 0x3f
function set_detect_ranges( hidden, spotted, var_8f3f480583606401 )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xaa>" );
    }
    
    scripts\stealth\manager::set_detect_ranges_internal( hidden, spotted, var_8f3f480583606401 );
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x8f4
// Size: 0xc1
function set_min_detect_range_darkness( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xcf>" );
    }
    
    if ( isdefined( hidden ) )
    {
        setstealthminrangedarkness( "hidden", "prone", hidden[ "prone" ] );
        setstealthminrangedarkness( "hidden", "crouch", hidden[ "crouch" ] );
        setstealthminrangedarkness( "hidden", "stand", hidden[ "stand" ] );
    }
    
    if ( isdefined( spotted ) )
    {
        setstealthminrangedarkness( "spotted", "prone", spotted[ "prone" ] );
        setstealthminrangedarkness( "spotted", "crouch", spotted[ "crouch" ] );
        setstealthminrangedarkness( "spotted", "stand", spotted[ "stand" ] );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x9bd
// Size: 0xc1
function function_f3883fe06a11269( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xcf>" );
    }
    
    if ( isdefined( hidden ) )
    {
        setstealthminrangeshadow( "hidden", "prone", hidden[ "prone" ] );
        setstealthminrangeshadow( "hidden", "crouch", hidden[ "crouch" ] );
        setstealthminrangeshadow( "hidden", "stand", hidden[ "stand" ] );
    }
    
    if ( isdefined( spotted ) )
    {
        setstealthminrangeshadow( "spotted", "prone", spotted[ "prone" ] );
        setstealthminrangeshadow( "spotted", "crouch", spotted[ "crouch" ] );
        setstealthminrangeshadow( "spotted", "stand", spotted[ "stand" ] );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xa86
// Size: 0x84
function do_stealth()
{
    if ( !isdefined( level.player.stealth ) )
    {
        scripts\stealth\init::set_stealth_mode( 1 );
    }
    
    switch ( self.team )
    {
        case #"hash_24b14065e10b1f8d":
        case #"hash_7c2d091e6337bf54":
            thread scripts\stealth\enemy::main();
            break;
        case #"hash_5f54b9bf7583687f":
            thread scripts\stealth\friendly::main();
            break;
        case #"hash_a571cacc018623b8":
            thread scripts\stealth\neutral::main();
            break;
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xb12
// Size: 0x10f
function save_last_goal()
{
    if ( isdefined( self.stealth.last_goal ) )
    {
        return;
    }
    
    self.saved_script_forcegoal = self.script_forcegoal;
    
    if ( isdefined( self.patharray ) )
    {
        if ( self.patharrayindex == self.patharray.size - 1 )
        {
            index = self.patharrayindex;
        }
        else
        {
            index = self.patharrayindex + 1;
        }
        
        self.stealth.last_goal = self.patharray[ index ];
        self.stealth.var_7fc1729e33311de3 = self.patharraystartnode;
        return;
    }
    
    if ( isdefined( self.last_set_goalnode ) )
    {
        self.stealth.last_goal = self.last_set_goalnode;
        return;
    }
    
    if ( isdefined( self.last_set_goalent ) )
    {
        self.stealth.last_goal = self.last_set_goalent;
    }
}

/#

    // Namespace utility / scripts\stealth\utility
    // Params 1
    // Checksum 0x0, Offset: 0xc29
    // Size: 0x19, Type: dev
    function set_patrol_move_loop_anim( animoverride )
    {
        assertmsg( "<dev string:xf4>" );
    }

#/

// Namespace utility / scripts\stealth\utility
// Params 4
// Checksum 0x0, Offset: 0xc4a
// Size: 0x51
function set_patrol_style( style, allowreact, reactposition, magnitude )
{
    switch ( style )
    {
        case #"hash_186d745a92c317d9":
            self.var_e31ee88092e41cc8 = 1;
            break;
    }
    
    self setpatrolstyle( style, allowreact, reactposition, magnitude );
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xca3
// Size: 0x1b
function get_patrol_style()
{
    assert( isdefined( self.stealth ) );
    return asm_getdemeanor();
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0xcc7
// Size: 0x1c
function set_patrol_react( position, magnitude )
{
    self setpatrolreact( position, magnitude );
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xceb
// Size: 0xb0, Type: bool
function function_783cf2a7aaab23c()
{
    if ( isdefined( self.fnstealthgotonode ) && isdefined( self.stealth.last_goal ) )
    {
        if ( isdefined( self.saved_script_forcegoal ) )
        {
            self.script_forcegoal = self.saved_script_forcegoal;
        }
        
        self thread [[ self.fnstealthgotonode ]]( self.stealth.last_goal, undefined, undefined, self.stealth.var_7fc1729e33311de3 );
        self.saved_script_forcegoal = undefined;
        self.stealth.last_goal = undefined;
        self.stealth.var_7fc1729e33311de3 = undefined;
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xda4
// Size: 0x32
function set_path_dist( ent )
{
    ent.distsqrd = get_path_dist_sq( self.origin, ent.origin, self );
}

// Namespace utility / scripts\stealth\utility
// Params 3
// Checksum 0x0, Offset: 0xdde
// Size: 0x78
function get_path_dist_sq( from, to, var_320b468dc1d97042 )
{
    path = self findpath( from, to );
    
    if ( isdefined( var_320b468dc1d97042 ) )
    {
        var_320b468dc1d97042.path = path;
    }
    
    distsq = 0;
    
    for ( i = 1; i < path.size ; i++ )
    {
        distsq += distancesquared( path[ i - 1 ], path[ i ] );
    }
    
    return distsq;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xe5f
// Size: 0x16
function remove_path_dist()
{
    self.path = undefined;
    self.distsqrd = undefined;
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xe7d
// Size: 0xad
function is_visible( other )
{
    if ( isplayer( self ) )
    {
        if ( within_fov( self.origin, self.angles, other.origin, 0.766 ) )
        {
            if ( isdefined( other.tagging_visible ) || tagging_shield() )
            {
                return 1;
            }
            
            if ( scripts\anim\utility_common::player_can_see_ai( self, other, 250 ) )
            {
                return 1;
            }
        }
    }
    else if ( isdefined( other.team ) && self.team == other.team )
    {
        return self cansee( other, 300 );
    }
    else
    {
        return self cansee( other );
    }
    
    return 0;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xf33
// Size: 0x3b, Type: bool
function tagging_shield()
{
    return isdefined( self.offhandshield ) && isdefined( self.offhandshield.active ) && self.offhandshield.active;
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xf77
// Size: 0x47
function setbattlechatter( state )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnsetbattlechatter ) )
    {
        return [[ level.stealth.fnsetbattlechatter ]]( state );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 6
// Checksum 0x0, Offset: 0xfc6
// Size: 0x74
function addeventplaybcs( eventaction, eventtype, modifier, delay, eventstruct, force )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnaddeventplaybcs ) )
    {
        return [[ level.stealth.fnaddeventplaybcs ]]( eventaction, eventtype, modifier, delay, eventstruct, force );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 6
// Checksum 0x0, Offset: 0x1042
// Size: 0x74
function animgenericcustomanimmode( guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0 )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnanimgenericcustomanimmode ) )
    {
        return [[ level.stealth.fnanimgenericcustomanimmode ]]( guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0 );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x10be
// Size: 0x11f
function stealth_music( musichidden, musicspotted )
{
    self notify( "stealth_music" );
    self endon( "stealth_music" );
    thread stealth_music_pause_monitor();
    
    while ( true )
    {
        flag_wait( "stealth_enabled" );
        flag_waitopen( "stealth_spotted" );
        flag_waitopen( "stealth_music_pause" );
        function_f81d9864f1fc95a6();
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musichidden );
        }
        
        flag_wait( "stealth_spotted" );
        flag_waitopen( "stealth_music_pause" );
        function_4efc63abff5f42d3();
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musicspotted );
        }
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x11e5
// Size: 0x3d
function function_4efc63abff5f42d3()
{
    if ( isdefined( level.var_667495cce3974c46 ) )
    {
        wait level.var_667495cce3974c46;
    }
    
    if ( getdvarint( @"hash_5cf56ca298c06c21", 0 ) != 0 )
    {
        wait getdvarint( @"hash_5cf56ca298c06c21", 0 );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x122a
// Size: 0x3d
function function_f81d9864f1fc95a6()
{
    if ( isdefined( level.var_e588ee33138024c3 ) )
    {
        wait level.var_e588ee33138024c3;
    }
    
    if ( getdvarint( @"hash_9a92f5b582657d72", 0 ) != 0 )
    {
        wait getdvarint( @"hash_9a92f5b582657d72", 0 );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x126f
// Size: 0x68
function stealth_music_stop()
{
    self notify( "stealth_music" );
    self notify( "stealth_music_pause_monitor" );
    
    foreach ( player in level.players )
    {
        player thread stealth_music_transition( undefined );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x12df
// Size: 0x146
function stealth_music_pause_monitor( musichidden, musicspotted )
{
    self notify( "stealth_music_pause_monitor" );
    self endon( "stealth_music_pause_monitor" );
    
    while ( true )
    {
        flag_wait( "stealth_music_pause" );
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( undefined );
        }
        
        flag_waitopen( "stealth_music_pause" );
        
        if ( flag( "stealth_spotted" ) )
        {
            foreach ( player in level.players )
            {
                player thread stealth_music_transition( musicspotted );
            }
            
            continue;
        }
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musichidden );
        }
    }
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x142d
// Size: 0x25
function stealth_music_transition( aliasto )
{
    if ( isdefined( self.fnstealthmusictransition ) )
    {
        return [[ self.fnstealthmusictransition ]]( aliasto );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x145a
// Size: 0x1b
function update_light_meter()
{
    if ( isdefined( self.fnupdatelightmeter ) )
    {
        return [[ self.fnupdatelightmeter ]]();
    }
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x147d
// Size: 0x124
function enable_stealth_for_ai( enabled )
{
    if ( !enabled )
    {
        self.maxvisibledist = 8192;
        
        if ( ent_flag_exist( "stealth_enabled" ) && ent_flag( "stealth_enabled" ) && self.team == "axis" )
        {
            dummyevent = spawnstruct();
            dummyevent.origin = level.player.origin;
            dummyevent.investigate_point = level.player.origin;
            dummyevent.investigate_pos = level.player.origin;
            dummyevent.type = "combat";
            dummyevent.typeorig = "attack";
            self.dontevershoot = 0;
            self.dontattackme = 0;
            scripts\stealth\enemy::bt_event_combat( dummyevent );
        }
    }
    
    if ( ent_flag_exist( "stealth_enabled" ) )
    {
        if ( enabled )
        {
            ent_flag_set( "stealth_enabled" );
            return;
        }
        
        ent_flag_clear( "stealth_enabled" );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x15a9
// Size: 0x68
function custom_state_functions( array )
{
    assertex( !isdefined( self.stealth ), "<dev string:x119>" );
    
    if ( isdefined( array[ "spotted" ] ) )
    {
        self.stealth_state_func[ "spotted" ] = array[ "spotted" ];
    }
    
    if ( isdefined( array[ "hidden" ] ) )
    {
        self.stealth_state_func[ "hidden" ] = array[ "hidden" ];
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x1619
// Size: 0x3c
function set_stealth_func( type, func )
{
    self.stealth.funcs[ type ] = func;
    
    if ( isai( self ) )
    {
        self function_a29879bf1276a08a( type, func );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x165d
// Size: 0x5b
function set_event_override( eventtype, funcoverride )
{
    if ( isdefined( eventtype ) && isdefined( self.stealth ) && isdefined( self.stealth.funcs ) )
    {
        self.stealth.funcs[ "event_" + eventtype ] = funcoverride;
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x16c0
// Size: 0x3a, Type: bool
function bcisincombat()
{
    self endon( "death" );
    
    if ( isdefined( self.fnisinstealthcombat ) && self [[ self.fnisinstealthcombat ]]() )
    {
        return true;
    }
    
    if ( !isdefined( self.stealth ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x1703
// Size: 0x4, Type: bool
function _autosave_stealthcheck()
{
    return true;
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x1710
// Size: 0x30
function get_player_drone()
{
    if ( isdefined( level.stealth.fngetplayerdrone ) )
    {
        return [[ level.stealth.fngetplayerdrone ]]( self );
    }
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x1748
// Size: 0x1d
function is_idling()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthidle ]]();
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x176e
// Size: 0x1d
function is_investigating()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthinvestigate ]]();
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x1794
// Size: 0x1d
function is_hunting()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthhunt ]]();
}

// Namespace utility / scripts\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x17ba
// Size: 0x1e
function function_6a86dd83c01f8faa()
{
    if ( !isdefined( self.stealth ) )
    {
        return 1;
    }
    
    return self [[ self.fnisinstealthcombat ]]();
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x17e1
// Size: 0x30
function function_c14048638b343b7f( state, event )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    self [[ self.fnsetstealthstate ]]( state, event );
}

// Namespace utility / scripts\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x1819
// Size: 0xbb
function function_6516755416a6584b( filter_func, severity )
{
    all_states = 0;
    
    if ( !isdefined( severity ) )
    {
        severity = [ "all" ];
        all_states = 1;
    }
    
    if ( !isarray( severity ) )
    {
        severity = [ severity ];
    }
    
    if ( !all_states )
    {
        all_states = array_contains( severity, "all" );
    }
    
    if ( all_states || array_contains( severity, "investigate" ) )
    {
        set_stealth_func( "event_investigate", filter_func );
    }
    
    if ( all_states || array_contains( severity, "cover_blown" ) )
    {
        set_stealth_func( "event_cover_blown", filter_func );
    }
    
    if ( all_states || array_contains( severity, "combat" ) )
    {
        set_stealth_func( "event_combat", filter_func );
    }
}

