#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using script_48324b060b129b7b;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\agent_drops;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;

#namespace namespace_9e536e4fbf2fc370;

/#

    // Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
    // Params 0
    // Checksum 0x0, Offset: 0x272
    // Size: 0x5, Type: dev
    function function_9f3c433728214c41()
    {
        
    }

#/

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x27f
// Size: 0x52
function function_1308ec055ee61e28( cleanup_flag )
{
    self endon( "death" );
    flag_wait( cleanup_flag );
    
    if ( !is_dead_or_dying( self ) )
    {
        self.nocorpse = 1;
        self.diequietly = 1;
        self notify( "cleanup_flashlight" );
        waitframe();
        self kill();
        waitframe();
        self delete();
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x2d9
// Size: 0x20
function ai_cleanup()
{
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    thread function_d8c25b92f26502ca();
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x301
// Size: 0x8c
function function_d8c25b92f26502ca()
{
    self endon( "death" );
    
    while ( true )
    {
        self getenemyinfo( level.player );
        self.goalradius = 50;
        self.script_goalradius = 50;
        self.goalheight = 100;
        self setgoalpos( level.player.origin );
        
        /#
            print3d( self geteye(), "<dev string:x1c>", ( 1, 1, 1 ), 0.5, 1, 5 );
        #/
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x395
// Size: 0xda
function function_390e9e76979a0a95()
{
    if ( !isdefined( level.player_kills ) )
    {
        level.player_kills = [];
    }
    
    var_7d686aac8fc4f606 = "";
    
    if ( isdefined( self.directorspawndata ) && isdefined( self.directorspawndata.script_stealthgroup ) )
    {
        var_7d686aac8fc4f606 = self.directorspawndata.script_stealthgroup;
    }
    else
    {
        while ( !isdefined( self.script_stealthgroup ) )
        {
            wait 0.25;
        }
        
        var_7d686aac8fc4f606 = self.script_stealthgroup;
    }
    
    if ( !isdefined( level.player_kills[ var_7d686aac8fc4f606 ] ) )
    {
        level.player_kills[ var_7d686aac8fc4f606 ] = 0;
    }
    
    self waittill( "death" );
    
    if ( function_dd0225b5ecf1da35() )
    {
        if ( function_5c2d4ec70d8c4bf7( var_7d686aac8fc4f606 ) )
        {
            level notify( "heli_obj_ai_killed" );
        }
        
        if ( isdefined( var_7d686aac8fc4f606 ) )
        {
            level.player_kills[ var_7d686aac8fc4f606 ]++;
        }
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x477
// Size: 0x6c, Type: bool
function function_dd0225b5ecf1da35()
{
    attacker_is_player = is_equal( self.lastattacker, level.player );
    var_f86c6b1119ef1461 = isdefined( self ) && isdefined( self.lastattacker ) && is_equal( self.lastattacker.owner, level.player );
    return attacker_is_player || var_f86c6b1119ef1461;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x4ec
// Size: 0x1f
function function_9114105b6ad6f6fa()
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    scripts\cp\agent_drops::function_8033aadb6558d0fe( "brloot_armor_plate" );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x513
// Size: 0x3a
function function_5c2d4ec70d8c4bf7( stealthgroup )
{
    var_e384707941ce4813 = [ "parking_lot", "heli_containment_group", "heli_spray_zone_group" ];
    return array_contains( var_e384707941ce4813, stealthgroup );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x556
// Size: 0x22
function function_a0afdc88b4bb5b9f( var_df62607731853a27 )
{
    if ( !function_709f0ed94c5d9149( var_df62607731853a27 ) )
    {
        return 0;
    }
    
    return level.player_kills[ var_df62607731853a27 ];
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0x581
// Size: 0x45
function function_a9229e71cac763a5( var_df62607731853a27, var_5d79ba52462cbde4 )
{
    while ( !function_709f0ed94c5d9149( var_df62607731853a27 ) )
    {
        wait 0.25;
    }
    
    while ( true )
    {
        if ( level.player_kills[ var_df62607731853a27 ] >= var_5d79ba52462cbde4 )
        {
            return;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x5ce
// Size: 0x2d, Type: bool
function function_709f0ed94c5d9149( var_df62607731853a27 )
{
    if ( !isdefined( level.player_kills ) || !isdefined( level.player_kills[ var_df62607731853a27 ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 3
// Checksum 0x0, Offset: 0x604
// Size: 0xe6
function function_ca53f38b1eb70113( origin, checkfov, dist )
{
    if ( !isdefined( checkfov ) )
    {
        checkfov = 1;
    }
    
    if ( checkfov && !within_fov( self.origin, self.angles, origin, cos( 180 ) ) )
    {
        return 0;
    }
    
    eye_origin = function_cabcc7c3e8682497();
    eye_angles = function_b071913d4b91319();
    
    if ( !isdefined( dist ) )
    {
        dist = 1024;
    }
    
    if ( !function_86c6afb41a6c383b( eye_origin, origin, dist ) )
    {
        return 0;
    }
    
    if ( function_86c6afb41a6c383b( eye_origin, origin, level.stealth.damage_sight_range ) )
    {
        return 1;
    }
    
    if ( checkfov )
    {
        if ( isai( self ) && !self aipointinfov( origin ) )
        {
            return 0;
        }
    }
    
    sight_contents = level.var_318ceae290567709;
    return scripts\engine\trace::ray_trace_passed( eye_origin, origin, [ self ], sight_contents );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 3
// Checksum 0x0, Offset: 0x6f3
// Size: 0x34, Type: bool
function function_86c6afb41a6c383b( start, end, dist )
{
    if ( !isdefined( start ) || !isdefined( end ) )
    {
        return false;
    }
    
    return distancesquared( start, end ) <= dist * dist;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x730
// Size: 0xb1
function function_cabcc7c3e8682497()
{
    if ( isdefined( self.eyeorigin ) )
    {
        if ( self.eyeorigintime == gettime() )
        {
            return self.eyeorigin;
        }
        
        if ( isdefined( self.eyeoriginpos ) && self.eyeoriginpos == self.origin )
        {
            return self.eyeorigin;
        }
    }
    
    if ( isai( self ) )
    {
        self.eyeorigin = self geteye();
    }
    else
    {
        self.eyeorigin = self gettagorigin( "tag_eye" );
        self.eyeoriginpos = self.origin;
    }
    
    self.eyeorigintime = gettime();
    return self.eyeorigin;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x7ea
// Size: 0x84
function function_b071913d4b91319()
{
    if ( isdefined( self.eyeangles ) )
    {
        if ( self.eyeanglestime == gettime() )
        {
            return self.eyeangles;
        }
        
        if ( isdefined( self.eyeanglesang ) && self.eyeanglesang == self.angles )
        {
            return self.eyeangles;
        }
    }
    
    self.eyeangles = self gettagangles( "tag_eye" );
    self.eyeanglestime = gettime();
    return self.eyeangles;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x877
// Size: 0xc
function function_f1868d2eb5549576()
{
    return getaiarray( "axis" );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x88c
// Size: 0x21
function function_c4b4355ce8443bad( event )
{
    self notify( "do_combat" );
    self notify( "anim_react_notify", "ai_event_high", event );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x8b5
// Size: 0x2c, Type: bool
function function_d5e8d37448f98cbf()
{
    if ( isalive( self ) )
    {
        if ( istrue( self.in_melee_death ) )
        {
            return true;
        }
        
        if ( istrue( self.in_melee ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x8ea
// Size: 0x18
function function_710f3a1c8b949939()
{
    if ( flag( "flag_player_near_heli_objective" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x90a
// Size: 0x83, Type: bool
function function_a8cf239507277966( radius )
{
    ai = coop_stealth::get_ai_within_range( level.player.origin, radius * radius, 12 );
    
    foreach ( bot in ai )
    {
        if ( bot scripts\stealth\utility::function_6a86dd83c01f8faa() )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
    // Params 0
    // Checksum 0x0, Offset: 0x996
    // Size: 0x5, Type: dev
    function function_f62797c380f8d975()
    {
        
    }

#/

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0x9a3
// Size: 0x95
function function_a20f67b33165ceb( ent_name )
{
    ents = getentarray( ent_name, "targetname" );
    assertex( isdefined( ents ), "No ents found by name " + ent_name );
    
    while ( true )
    {
        foreach ( ent in ents )
        {
            if ( level.player istouching( ent ) )
            {
                return;
            }
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0xa40
// Size: 0x9e
function function_3c86a0e24dbc568c( ent_name, var_acba072b7e847a86 )
{
    if ( flag( var_acba072b7e847a86 ) )
    {
        return;
    }
    
    ents = getentarray( ent_name, "targetname" );
    
    while ( true )
    {
        foreach ( ent in ents )
        {
            if ( ent istouching( level.player ) )
            {
                flag_set( var_acba072b7e847a86 );
                return;
            }
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0xae6
// Size: 0xb7
function function_fb715226804a8bf0( ent_name, var_77386067ddbb480f )
{
    if ( !flag( var_77386067ddbb480f ) )
    {
        return;
    }
    
    ents = getentarray( ent_name, "targetname" );
    
    while ( true )
    {
        is_touching = 0;
        
        foreach ( ent in ents )
        {
            if ( ent istouching( level.player ) )
            {
                is_touching = 1;
                break;
            }
        }
        
        if ( !istrue( is_touching ) )
        {
            flag_clear( var_77386067ddbb480f );
            return;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0xba5
// Size: 0x2d
function function_dc4056eea98d12aa( ent_name, var_acba072b7e847a86 )
{
    while ( true )
    {
        function_3c86a0e24dbc568c( ent_name, var_acba072b7e847a86 );
        function_fb715226804a8bf0( ent_name, var_acba072b7e847a86 );
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 3
// Checksum 0x0, Offset: 0xbda
// Size: 0x2c
function function_47f9161df3ed9965( var_acba072b7e847a86, var_df62607731853a27, var_5d79ba52462cbde4 )
{
    function_a9229e71cac763a5( var_df62607731853a27, var_5d79ba52462cbde4 );
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0xc0e
// Size: 0x45
function function_6027ea065378eafc( var_acba072b7e847a86, dvar )
{
    while ( true )
    {
        function_c306c2fab085ed0e( dvar, 1, &flag_set, [ var_acba072b7e847a86 ] );
        function_c306c2fab085ed0e( dvar, 0, &flag_clear, [ var_acba072b7e847a86 ] );
        waitframe();
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0xc5b
// Size: 0x6b, Type: bool
function function_5b9db63ed4d034e0( flag_array )
{
    if ( !isarray( flag_array ) )
    {
        flag_array = [ flag_array ];
    }
    
    foreach ( f in flag_array )
    {
        if ( !flag( f ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 8
// Checksum 0x0, Offset: 0xccf
// Size: 0xc1
function function_bdc60d1ad098faa4( var_acba072b7e847a86, position, fov, should_trace, max_distance, delay, endon_msg, ignore_list )
{
    level.player endon( "death" );
    
    if ( isdefined( endon_msg ) )
    {
        level endon( endon_msg );
    }
    
    while ( true )
    {
        wait 0.25;
        
        if ( isdefined( max_distance ) && distance2d( level.player.origin, position ) > max_distance )
        {
            continue;
        }
        
        results = function_e7c30095a6cdc3ef( position, fov, should_trace, ignore_list );
        
        if ( results == 1 )
        {
            break;
        }
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 4
// Checksum 0x0, Offset: 0xd98
// Size: 0xf8, Type: bool
function function_e7c30095a6cdc3ef( position, fov, should_trace, ignore_list )
{
    if ( !isdefined( level.player ) )
    {
        return false;
    }
    
    if ( !isdefined( fov ) )
    {
        fov = getdvarint( @"cg_fov" );
    }
    
    if ( !isdefined( should_trace ) )
    {
        should_trace = 1;
    }
    
    in_fov = within_fov( level.player geteye(), level.player getplayerangles(), position, cos( fov ) );
    
    if ( !in_fov )
    {
        return false;
    }
    
    if ( !should_trace )
    {
        return true;
    }
    
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
    castresult = physics_raycast( level.player geteye(), position, contents, ignore_list, 0, "physicsquery_closest", 0 );
    
    if ( isdefined( castresult ) && castresult.size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 1
// Checksum 0x0, Offset: 0xe99
// Size: 0x39
function function_4b960aab950cb97b( var_3feca07ce33bbe6d )
{
    if ( level.var_9df79069dfd8549b >= var_3feca07ce33bbe6d )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( "heli_killed" );
        
        if ( level.var_9df79069dfd8549b >= var_3feca07ce33bbe6d )
        {
            return;
        }
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0xeda
// Size: 0x69
function function_6941c0b810d537da( org, dist )
{
    while ( !isdefined( level.player ) )
    {
        wait 1;
    }
    
    level endon( "game_ended" );
    level.player endon( "death" );
    
    while ( true )
    {
        if ( distance2d( level.player.origin, org ) < dist )
        {
            return;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xf4b
// Size: 0x123
function private function_e6fc53e242f10d37( string, spawn_type )
{
    self endon( "death" );
    
    /#
        if ( !isdefined( string ) )
        {
            iprintlnbold( "<dev string:x25>" + self.origin );
            return;
        }
        
        color = ( 1, 1, 1 );
        
        switch ( spawn_type )
        {
            case #"hash_fc8ba1ef13294e43":
                color = ( 0.5, 1, 0.5 );
                string = "<dev string:x54>" + string;
                break;
            case #"hash_170d49a30056e0cb":
                color = ( 0.1, 1, 0 );
                string = "<dev string:x61>" + string;
                break;
            case #"hash_1348205e57bdc81":
                color = ( 0, 1, 0.8 );
                string = "<dev string:x6f>" + string;
                break;
            default:
                break;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_42417cffcfb34e5", 0 ) )
            {
                if ( isdefined( string ) )
                {
                    print3d( self.origin - ( 0, 0, 10 ), string, color, 1, 0.75 );
                }
            }
            
            waitframe();
        }
    #/
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x1076
// Size: 0x18
function force_high_reaction()
{
    self aieventlistenerevent( "cover_blown", self, self.origin );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x1096
// Size: 0x18
function force_low_reaction()
{
    self aieventlistenerevent( "investigate", self, self.origin );
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 2
// Checksum 0x0, Offset: 0x10b6
// Size: 0x48
function function_f44373e9086f201e( text, tag )
{
    self endon( "death" );
    
    /#
        while ( true )
        {
            pos = self gettagorigin( tag );
            print3d( pos, text, undefined, undefined, 1, 1, 1 );
            waitframe();
        }
    #/
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 5
// Checksum 0x0, Offset: 0x1106
// Size: 0x8f
function function_cf47dd33b7a1a9fc( var_f13284feaaa23950, guy_2, duration, color, alpha )
{
    var_f13284feaaa23950 endon( "death" );
    guy_2 endon( "death" );
    
    if ( !isdefined( color ) )
    {
        color = ( 1, 1, 0 );
    }
    
    duration *= 4;
    
    for ( i = 0; i < duration ; i++ )
    {
        drawline( var_f13284feaaa23950.origin, guy_2.origin, 0.25, color, alpha );
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x119d
// Size: 0x4a
function function_ca11fd490cc8bbcc()
{
    while ( true )
    {
        wait 0.25;
        
        if ( !scripts\stealth\utility::any_groups_in_combat() )
        {
            continue;
        }
        
        wait 6;
        
        if ( !scripts\stealth\utility::any_groups_in_combat() )
        {
            continue;
        }
        
        flag_set( "flag_sustained_combat_active" );
        function_ce3d40259f555eba();
        flag_clear( "flag_sustained_combat_active" );
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x11ef
// Size: 0x1a
function function_ce3d40259f555eba()
{
    while ( true )
    {
        wait 0.25;
        
        if ( !scripts\stealth\utility::any_groups_in_combat() )
        {
            return;
        }
    }
}

// Namespace namespace_9e536e4fbf2fc370 / namespace_a3ae8fde81bd3c08
// Params 0
// Checksum 0x0, Offset: 0x1211
// Size: 0x1a
function function_91da54e1e2dd71a0()
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    scripts\cp_mp\agents\agent_utils::despawnagent();
}

