#using script_102d83a437e2b29f;
#using script_1f26e1f43fae865c;
#using script_2b9373071eab7afc;
#using script_2e301dbc588668b1;
#using script_391739915ba4b7dd;
#using script_3a8f9ace195c9da9;
#using script_48324b060b129b7b;
#using script_4f91372b79c514b7;
#using script_681b3034f1bd25ee;
#using scripts\anim\dialogue;
#using scripts\anim\squadmanager;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\nvg_ai;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\entityheadicons;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace namespace_41966f109cd424ff;

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x11e5
// Size: 0x238
function function_c4869b83b43e420f( group_name, func )
{
    if ( istrue( self.bhasriotshieldattached ) )
    {
        self.var_2626d6897d71b728 = 1400;
        self.allowstrafe = 1;
    }
    
    scripts\cp\coop_stealth::run_common_functions( self, 1, 1, 60, 160000 );
    self.var_a4709d00b598b7bf = 1;
    self.maystumble = 0;
    self.shouldstumble = 0;
    thread function_80dc965028d873a2();
    thread function_82cdd0ff660ce304();
    thread function_6b057f33caf799af();
    thread function_b77fa6d696666245();
    self.stealth.funcs[ "event_investigate" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "event_cover_blown" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "event_combat" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "should_hunt" ] = &function_23cc696ddb16ab42;
    
    if ( flag( "stealth_spotted" ) )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        player = level.player;
        
        if ( isdefined( player ) )
        {
            self setgoalpos( player.origin );
            event = spawnstruct();
            event.typeorig = "combat";
            event.type = "combat";
            event.origin = player.origin;
            event.investigate_pos = player.origin;
            self [[ self.fnsetstealthstate ]]( "combat", event );
        }
        
        self getenemyinfo( level.player );
        return;
    }
    
    if ( flag( "broke_stealth_earlier" ) )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
        self aieventlistenerevent( "damage", self, self.origin );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x1425
// Size: 0x12a
function function_16e5f29b3aebbc0f( group_name, func )
{
    if ( getdvarint( @"hash_dcf5fcede3345fb8", 0 ) != 0 || getdvarint( @"hash_d8d47ba9a7e3f94c", 0 ) != 0 )
    {
        self.ignoreall = 1;
    }
    
    scripts\cp\coop_stealth::run_common_functions( self, 1, 1, 60, 160000 );
    self.var_a4709d00b598b7bf = 1;
    self.maystumble = 0;
    self.shouldstumble = 0;
    self.var_5323a94889eff1de = 1;
    thread function_80dc965028d873a2();
    thread function_82cdd0ff660ce304();
    thread function_6b057f33caf799af();
    self.stealth.funcs[ "event_investigate" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "event_cover_blown" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "event_combat" ] = &function_f161c068112045e3;
    self.stealth.funcs[ "should_hunt" ] = &function_23cc696ddb16ab42;
    self [[ self.fnsetstealthstate ]]( "hunt" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x1557
// Size: 0x104
function function_38ba7b842978ba92( group_name, func )
{
    self endon( "death" );
    
    if ( getdvarint( @"hash_dcf5fcede3345fb8", 0 ) != 0 )
    {
        self.ignoreall = 1;
    }
    
    self.var_5323a94889eff1de = 1;
    self.goalradius = 100;
    function_41916c7ce22f8f8b( 0 );
    thread function_6b057f33caf799af();
    
    if ( isdefined( self.heli ) )
    {
        self.heli waittill( "unloaded" );
    }
    
    if ( isdefined( self.target ) )
    {
        goal_struct = getstruct( self.target, "targetname" );
        thread scripts\cp\spawning::enter_combat_after_go_to_node( goal_struct );
        waittill_any_return_2( "reached_path_end", "stop_going_to_node" );
        wait randomfloatrange( 10, 30 );
    }
    
    goal_vol = function_1c4d592029f2b0d3( self.script_squadname );
    self setgoalvolumeauto( goal_vol );
    self getenemyinfo( level.player );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x1663
// Size: 0x3c
function function_3e28d41bce5691de( group_name, func )
{
    self.ignoreall = 1;
    function_41916c7ce22f8f8b( 0 );
    self.baseaccuracy = 0.2;
    thread function_c4869b83b43e420f();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x16a7
// Size: 0x69
function function_f3e8f4cd089693dc()
{
    wait 1;
    guys = function_c890afce78d098bb( "pre_hvt_roof_group" );
    
    foreach ( guy in guys )
    {
        guy.ignoreall = 0;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1718
// Size: 0x39
function function_b77fa6d696666245()
{
    self waittill( "death", attacker );
    
    if ( is_equal( attacker, level.player ) )
    {
        level notify( "player_killed_enemy", self.origin );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1759
// Size: 0x51
function function_80dc965028d873a2()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        
        if ( !flag( "broke_stealth_earlier" ) && flag( "flag_apt_basement_complete" ) )
        {
            /#
                iprintlnbold( "<dev string:x1c>" );
            #/
            
            flag_set( "broke_stealth_earlier" );
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x17b2
// Size: 0x48
function function_82cdd0ff660ce304()
{
    self endon( "death" );
    
    if ( flag( "broke_stealth_earlier" ) )
    {
        return;
    }
    
    level waittill( "broke_stealth_earlier" );
    self aieventlistenerevent( "gunshot", level.player, level.player.origin );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1802
// Size: 0x4, Type: bool
function function_23cc696ddb16ab42()
{
    return true;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x180f
// Size: 0x1d7, Type: bool
function function_f161c068112045e3( event )
{
    var_945a77968466cbf5 = [ "explode", "gunshot", "gunshot_impact", "gunshot_teammate" ];
    
    if ( array_contains( var_945a77968466cbf5, event.typeorig ) )
    {
        if ( !flag( "broke_stealth_earlier" ) && flag( "flag_apt_basement_complete" ) )
        {
            /#
                iprintlnbold( "<dev string:x1c>" );
            #/
            
            flag_set( "broke_stealth_earlier" );
        }
    }
    
    ignore_events = [ "silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact", "glass_destroyed" ];
    
    if ( array_contains( ignore_events, event.typeorig ) )
    {
        if ( isdefined( event.origin ) )
        {
            val = abs( event.origin[ 2 ] - self.origin[ 2 ] );
            
            if ( function_d4a08728bf86e790( event ) )
            {
                return true;
            }
            
            if ( !self hastacvis( event.origin, 1 ) && !function_ca53f38b1eb70113( event.origin, 1, level.var_8ee9c5604a4fb6c0 ) )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( event.type ) && event.type == "combat" || event.type == "cover_blown" )
    {
        self.goalradius = 128;
        return false;
    }
    
    return false;
}

/#

    // Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
    // Params 0
    // Checksum 0x0, Offset: 0x19ef
    // Size: 0x5, Type: dev
    function function_6679f755585308e3()
    {
        
    }

#/

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x19fc
// Size: 0x329
function function_3649512a462f8e82()
{
    flag_wait( "player_spawned_with_loadout" );
    var_8f84070c103df063 = "";
    var_57dcc5408e440a8e = getdvarint( @"hash_c26ed9763bcd436a", 1 );
    
    switch ( var_57dcc5408e440a8e )
    {
        case 1:
            var_8f84070c103df063 = "_ar";
            break;
        case 2:
            var_8f84070c103df063 = "_lmg";
            break;
        case 3:
            var_8f84070c103df063 = "_shotgun";
            break;
        case 4:
            var_8f84070c103df063 = "_rpg";
            break;
        case 5:
            var_8f84070c103df063 = "_jugg";
            break;
    }
    
    spawn_loc = "hostage_spawner" + var_8f84070c103df063;
    spawn_state = undefined;
    
    switch ( level.start_point )
    {
        case #"hash_90053b4e0252c7a6":
            spawn_loc = "hostage_attach_spawner";
            spawn_state = 1;
            break;
        case #"hash_7c31479cf04292f":
        case #"hash_8b567e450ad3ae21":
            spawn_loc = "hostage_attach_spawner";
            spawn_state = 2;
            break;
    }
    
    level.hvt = spawnhostage( spawn_loc, spawn_state, undefined, &namespace_24fed8bd28d362b::function_150874ef396ff6e );
    level thread function_aced833bb509e9c2();
    
    if ( is_equal( getdvarint( @"hash_d8d47ba9a7e3f94c", 0 ), 1 ) )
    {
        var_cb49687c239b9674 = getstruct( "hostage_attach_spawner", "targetname" );
        level.hvt.ignoreall = 1;
        level.hvt.origin = var_cb49687c239b9674.origin;
        level.hvt.goalradius = 100;
        level.hvt setgoalpos( level.hvt.origin );
        level.hvt.helmethealth = 1;
        level.hvt.armorhealth = 1;
        level.hvt.armor_health = 1;
        level.hvt.health = 1;
        flag_set( "player_detected_on_roof" );
        flag_set( "flag_dungeon_hostage_interact_enabled" );
        return;
    }
    
    if ( !isdefined( spawn_state ) )
    {
        level.hvt.helmethealth = 100;
        level.hvt.armorhealth = 1250;
        level.hvt.armor_health = 1250;
        level.hvt.health = 1250;
        level.hvt.allowpain = 0;
        level.hvt.animname = "hvt";
        level.hvt.disablepistol = 1;
        level.hvt thread function_e72ce7df711d6518();
        level.hvt thread function_c572440073a4a21e();
        level.hvt thread function_f28628d3d0e4571d();
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1d2d
// Size: 0x44
function function_aced833bb509e9c2()
{
    while ( true )
    {
        level.player waittill( "hostage_picked_up" );
        thread namespace_78ef5a12a453ec66::function_63e6de435da0d83f();
        level.player waittill_either( "hostage_drop_complete", "end_hostage_carry" );
        thread namespace_78ef5a12a453ec66::function_55b61726e8e1f043();
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1d79
// Size: 0x1e
function function_f28628d3d0e4571d()
{
    level.hvt waittill( "damage" );
    flag_set( "player_first_damaged_hostage" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1d9f
// Size: 0x38
function function_c572440073a4a21e()
{
    level thread function_3f6b70959627cf12();
    level thread function_9a067ee837c25061();
    flag_wait( "player_detected_on_roof" );
    function_7a23492540716bbe();
    level.hvt thread function_38ba7b842978ba92();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1ddf
// Size: 0x104
function function_7a23492540716bbe()
{
    var_4e5e2e35fb485438 = function_a07a9c680ab79d90( level.hvt, level.player );
    var_b07d19d32a3e2618 = 0;
    
    switch ( var_4e5e2e35fb485438 )
    {
        case #"hash_232a3d188fcc5c69":
            var_b07d19d32a3e2618 = 2;
            break;
        case #"hash_8ff62271106f45ee":
            var_b07d19d32a3e2618 = 8;
            break;
        case #"hash_c9b3133a17a3b2d0":
            var_b07d19d32a3e2618 = 4;
            break;
        case #"hash_96815ce4f2a3dbc5":
            var_b07d19d32a3e2618 = 6;
            break;
        default:
            var_b07d19d32a3e2618 = 8;
            break;
    }
    
    anim_base = "speech_react_";
    
    if ( flag( "player_damaged_hostage" ) )
    {
        anim_base = "speech_pain_";
    }
    
    level.hvt function_e483413541e6f5cc();
    var_f274c46cd89843ac = anim_base + var_b07d19d32a3e2618;
    animnode = function_7a18da6e48b71c35( "speech_animnode" );
    animnode anim_single_solo( level.hvt, var_f274c46cd89843ac );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1eeb
// Size: 0x5d
function function_3f6b70959627cf12()
{
    while ( true )
    {
        msg = level.player waittill_any_return_2( "weapon_fired", "grenade_fire" );
        
        if ( msg == "grenade_fire" )
        {
            wait 2;
            break;
        }
        
        if ( msg == "weapon_fired" )
        {
            break;
        }
    }
    
    wait 0.1;
    flag_set( "player_detected_on_roof" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1f50
// Size: 0x3a
function function_9a067ee837c25061()
{
    level.hvt waittill_any_2( "damage" );
    iprintln( "hostage damaged" );
    flag_set( "player_damaged_hostage" );
    flag_set( "player_detected_on_roof" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1f92
// Size: 0x1c
function function_c40cd8a3af26fb4a()
{
    wait 45;
    iprintln( "hostage timeout" );
    flag_set( "player_detected_on_roof" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x1fb6
// Size: 0x35
function function_e72ce7df711d6518()
{
    level endon( "player_detected_on_roof" );
    animnode = function_7a18da6e48b71c35( "speech_animnode" );
    
    while ( true )
    {
        animnode anim_single_solo( self, "speech" );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x1ff3
// Size: 0x2e, Type: bool
function function_d4a08728bf86e790( ent )
{
    return abs( ent.origin[ 2 ] - self.origin[ 2 ] ) > 65;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x202a
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

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x2119
// Size: 0x34, Type: bool
function function_86c6afb41a6c383b( start, end, dist )
{
    if ( !isdefined( start ) || !isdefined( end ) )
    {
        return false;
    }
    
    return distancesquared( start, end ) <= dist * dist;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x2156
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

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x2210
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

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x229d
// Size: 0x4c
function spawn_on_stealth_break( spawner_name, spawn_func, endon_flag )
{
    if ( flag( endon_flag ) )
    {
        return;
    }
    
    level endon( endon_flag );
    
    if ( !flag( "broke_stealth_earlier" ) )
    {
        flag_wait( "broke_stealth_earlier" );
    }
    
    function_6149b301ce19988b( spawner_name, spawn_func );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x22f1
// Size: 0xce
function postspawn_axis()
{
    self endon( "death" );
    level.player endon( "death" );
    self.og_grenadeammo = self.grenadeammo;
    self.var_93e1660d079756ec = 1;
    self.var_cbd87a0bc497b778 = 1;
    self function_d493e7fe15e5eaf4( "jup_sandbox_apt" );
    self function_8bbcaeb23a1512ef( "all", 1 );
    
    while ( true )
    {
        z_dist = abs( level.player.origin[ 2 ] - self.origin[ 2 ] );
        
        if ( z_dist < 90 )
        {
            function_35a7b2cef0e43578( 1 );
            function_c14c0580f77c03c0( 1 );
        }
        else if ( z_dist > 90 )
        {
            function_35a7b2cef0e43578( 0 );
            function_c14c0580f77c03c0( 0 );
        }
        
        wait 0.5;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x23c7
// Size: 0x62
function function_35a7b2cef0e43578( enable )
{
    if ( isdefined( self.var_df91633b6e4f8115 ) && !self.var_10f89ce413710217 )
    {
        return;
    }
    
    var_b0e1e39c1aab49c8 = istrue( self.battlechatterallowed );
    
    if ( !var_b0e1e39c1aab49c8 && enable )
    {
        set_battlechatter( 1 );
        return;
    }
    
    if ( var_b0e1e39c1aab49c8 && !enable )
    {
        set_battlechatter( 0 );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2431
// Size: 0x73
function function_c14c0580f77c03c0( enable )
{
    if ( !self.var_93e1660d079756ec && enable )
    {
        self.grenadeammo = self.og_grenadeammo;
        self.var_93e1660d079756ec = enable;
        return;
    }
    
    if ( self.var_93e1660d079756ec && !enable )
    {
        self.og_grenadeammo = self.grenadeammo;
        self.grenadeammo = 0;
        self.var_93e1660d079756ec = enable;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x24ac
// Size: 0x1d
function function_8f08378040f01528( state )
{
    self.var_10f89ce413710217 = state;
    set_battlechatter( state );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x24d1
// Size: 0x1f
function function_41916c7ce22f8f8b( ammo )
{
    self.og_grenadeammo = ammo;
    self.var_934c33e7d6dfb43d = ammo;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x24f8
// Size: 0x95
function function_13b290df07ddc09d( range )
{
    if ( isdefined( level.var_c351736df6ca950a ) && gettime() - level.var_c351736df6ca950a < 1000 )
    {
        return;
    }
    
    var_3d37bfb60d26484e = get_nearby_enemy( level.player.origin, range * range, 1 );
    
    if ( !isdefined( var_3d37bfb60d26484e ) )
    {
        return;
    }
    
    var_3d37bfb60d26484e aieventlistenerevent( "investigate", level.player, level.player.origin );
    level.var_c351736df6ca950a = gettime();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x2595
// Size: 0xe4
function get_nearby_enemy( org, dist_check, var_1923f9515bd5bb36 )
{
    if ( !isdefined( dist_check ) )
    {
        dist_check = 25000000;
    }
    
    if ( !isdefined( var_1923f9515bd5bb36 ) )
    {
        var_1923f9515bd5bb36 = 0;
    }
    
    guys = getaiarray( "axis" );
    
    if ( !isdefined( guys ) )
    {
        return undefined;
    }
    
    guys = sortbydistance( guys, org );
    guys = array_removedead_or_dying( guys );
    
    foreach ( guy in guys )
    {
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( istrue( var_1923f9515bd5bb36 ) && !function_1923f9515bd5bb36( guy.origin, org ) )
        {
            continue;
        }
        
        if ( distancesquared( guy.origin, org ) < dist_check )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2682
// Size: 0x24, Type: bool
function function_1923f9515bd5bb36( org1, org2 )
{
    return abs( org1[ 2 ] - org2[ 2 ] ) < 110;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x26af
// Size: 0x1c
function function_e7dd556ef8061d94( note, flagname )
{
    self notify( "glasspile_footstep", note );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x26d3
// Size: 0x53
function function_900a3e3171bed15d()
{
    anim.notetracks[ "footstep_right_large" ] = &function_e7dd556ef8061d94;
    anim.notetracks[ "footstep_left_large" ] = &function_e7dd556ef8061d94;
    trigs = getentarray( "glass_pile", "targetname" );
    array_thread( trigs, &function_8738a6d03f226533 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x272e
// Size: 0x4e
function function_8738a6d03f226533()
{
    while ( true )
    {
        self waittill( "trigger", ent );
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( istrue( ent.var_32d228b5c9e80fee ) )
        {
            continue;
        }
        
        ent.var_32d228b5c9e80fee = 1;
        thread function_2f919270dcb65301( ent );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2784
// Size: 0x2c
function function_2f919270dcb65301( ent )
{
    while ( true )
    {
        if ( !ent istouching( self ) )
        {
            break;
        }
        
        waitframe();
    }
    
    ent.var_32d228b5c9e80fee = undefined;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x27b8
// Size: 0x10b
function function_6b057f33caf799af()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "glasspile_footstep", notetrack );
        var_5dca1397e809218e = undefined;
        
        switch ( notetrack )
        {
            case #"hash_ae9e723938772559":
                var_5dca1397e809218e = "tag_ik_foot_loc_le";
                break;
            case #"hash_980f8edcfab2adbe":
                var_5dca1397e809218e = "tag_ik_foot_loc_ri";
                break;
            default:
                assert( "broken_glass_think_ai: Didn't recognize notetrack " + notetrack );
                break;
        }
        
        pos = self gettagorigin( var_5dca1397e809218e );
        
        if ( !istrue( self.var_32d228b5c9e80fee ) )
        {
            continue;
        }
        
        if ( distance( level.player.origin, pos ) > 800 )
        {
            continue;
        }
        
        if ( !function_1923f9515bd5bb36( pos, level.player.origin ) )
        {
            continue;
        }
        
        vel = self getvelocity();
        enemy_speed = length2d( vel );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x28cb
// Size: 0xf4
function function_144d34e93cc17d70()
{
    while ( !isdefined( level.player ) )
    {
        wait 1;
    }
    
    level.player endon( "death" );
    
    while ( true )
    {
        waitframe();
        level.var_20011be2ab21a023 = length2d( level.player getvelocity() );
        
        if ( !istrue( level.player.var_32d228b5c9e80fee ) )
        {
            continue;
        }
        
        if ( level.player getstance() != "stand" )
        {
            continue;
        }
        
        vel = level.player getvelocity();
        playerspeed = length2d( vel );
        
        if ( playerspeed <= 10 )
        {
            continue;
        }
        
        if ( playerspeed <= 40 )
        {
            wait 1.3;
        }
        
        if ( playerspeed <= 180 && playerspeed > 41 )
        {
            function_13b290df07ddc09d( 300 );
            wait 0.4;
        }
        
        if ( playerspeed > 156 )
        {
            function_13b290df07ddc09d( 500 );
            wait 0.2;
        }
    }
}

/#

    // Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
    // Params 0
    // Checksum 0x0, Offset: 0x29c7
    // Size: 0x5, Type: dev
    function function_b4c31ab9b8841cdf()
    {
        
    }

#/

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x29d4
// Size: 0x98
function function_4bbb923dd77b3c69( var_bee5223e3ec7b072, end_on, var_905e82a1d3f82643 )
{
    if ( isdefined( end_on ) )
    {
        level endon( end_on );
    }
    
    if ( !isdefined( level.var_56ae11caa732bbc8 ) )
    {
        level.var_56ae11caa732bbc8 = 0;
    }
    
    level.var_56ae11caa732bbc8++;
    var_5940525b24792da5 = level.var_56ae11caa732bbc8;
    var_6e0487f2ff5f8c2d = var_5940525b24792da5 + "_fired";
    trigs = getentarray( var_bee5223e3ec7b072, "targetname" );
    function_9b971e1bc95bc1df( trigs, &function_3853d8752a87257e, var_6e0487f2ff5f8c2d );
    thread function_156aa6574272ff4f( var_6e0487f2ff5f8c2d, var_905e82a1d3f82643 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2a74
// Size: 0x19
function function_3853d8752a87257e( var_6e0487f2ff5f8c2d )
{
    level endon( var_6e0487f2ff5f8c2d );
    function_ae165af362de18a2();
    level notify( var_6e0487f2ff5f8c2d );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2a95
// Size: 0x74
function function_156aa6574272ff4f( var_6e0487f2ff5f8c2d, var_905e82a1d3f82643 )
{
    level waittill( var_6e0487f2ff5f8c2d );
    
    if ( !isarray( var_905e82a1d3f82643 ) )
    {
        var_905e82a1d3f82643 = [ var_905e82a1d3f82643 ];
    }
    
    foreach ( text in var_905e82a1d3f82643 )
    {
        temp_dialogue( text );
        wait 4;
    }
}

/#

    // Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
    // Params 0
    // Checksum 0x0, Offset: 0x2b11
    // Size: 0x5, Type: dev
    function function_270ddda37cd1ef3f()
    {
        
    }

#/

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2b1e
// Size: 0x27
function function_95c757df3143199c( str )
{
    if ( getdvarint( @"hash_14a9194f8f93a311", 0 ) == 0 )
    {
        return;
    }
    
    iprintln( str );
}

/#

    // Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
    // Params 0
    // Checksum 0x0, Offset: 0x2b4d
    // Size: 0x5, Type: dev
    function function_7b98cd58be12c92e()
    {
        
    }

#/

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2b5a
// Size: 0x27
function function_ecc08f04b844e42( enemy_group, num )
{
    while ( enemy_group.size > num )
    {
        waitframe();
        enemy_group = function_fdc9d5557c53078e( enemy_group );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2b89
// Size: 0x60
function function_7eaa0ff004b76f49( var_2a4433b9b0607161 )
{
    kill_count = 0;
    var_2dab25a4d05e9799 = function_8ffc4f7aecd48d4();
    
    while ( true )
    {
        wait 0.1;
        var_ebb06fe2c2e0f43 = function_8ffc4f7aecd48d4();
        
        if ( var_2dab25a4d05e9799 > var_ebb06fe2c2e0f43 )
        {
            kill_count += var_2dab25a4d05e9799 - var_ebb06fe2c2e0f43;
        }
        
        var_2dab25a4d05e9799 = var_ebb06fe2c2e0f43;
        
        if ( kill_count >= var_2a4433b9b0607161 )
        {
            break;
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x2bf1
// Size: 0xa8
function function_8ffc4f7aecd48d4()
{
    var_735daa6eca917989 = 0;
    
    if ( isdefined( level.var_92fa04e91db30b02 ) )
    {
        level.var_92fa04e91db30b02 = array_removedead_or_dying( level.var_92fa04e91db30b02 );
        var_735daa6eca917989 += level.var_92fa04e91db30b02.size;
    }
    
    if ( isdefined( level.var_768baef6b13e756f ) )
    {
        level.var_768baef6b13e756f = array_removedead_or_dying( level.var_768baef6b13e756f );
        var_735daa6eca917989 += level.var_768baef6b13e756f.size;
    }
    
    if ( isdefined( level.var_5fce6737102b328a ) )
    {
        level.var_5fce6737102b328a = array_removedead_or_dying( level.var_5fce6737102b328a );
        var_735daa6eca917989 += level.var_5fce6737102b328a.size;
    }
    
    return var_735daa6eca917989;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2ca2
// Size: 0x3b
function function_d14fcd3a04720601( trig_targetname )
{
    trigs = getentarray( trig_targetname, "targetname" );
    array_thread( trigs, &function_ae165af362de18a2 );
    waittill_any_ents_array( trigs, "player_trigger" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2ce5
// Size: 0x66
function function_ae165af362de18a2( var_420491156bf6835d )
{
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            continue;
        }
        
        if ( !scripts\cp\utility\player::isreallyalive( entity ) )
        {
            continue;
        }
        
        if ( istrue( var_420491156bf6835d ) )
        {
            self notify( "player_trigger", entity );
            continue;
        }
        
        break;
    }
    
    level.color_trig = self;
    self notify( "player_trigger", entity );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2d53
// Size: 0x50
function function_345b441e6d9da33c( ent, dist )
{
    ent endon( "death" );
    
    while ( true )
    {
        if ( distance( level.player.origin, ent.origin ) < dist )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2dab
// Size: 0xa2
function function_a44c98e5ec0f3b0c( org, var_1923f9515bd5bb36 )
{
    if ( !isdefined( var_1923f9515bd5bb36 ) )
    {
        var_1923f9515bd5bb36 = 0;
    }
    
    guys = getaiarray( "axis" );
    
    if ( !isdefined( guys ) )
    {
        return undefined;
    }
    
    guys = array_removedead_or_dying( guys );
    guys = sortbydistance( guys, org );
    
    foreach ( guy in guys )
    {
        if ( function_1923f9515bd5bb36( guy.origin, org ) )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x2e56
// Size: 0xd3
function function_c890afce78d098bb( names )
{
    if ( !isarray( names ) )
    {
        names = [ names ];
    }
    
    matches = [];
    
    foreach ( n in names )
    {
        foreach ( ai in level.spawned_enemies )
        {
            if ( is_equal( n, ai.enemy_group ) )
            {
                matches[ matches.size ] = ai;
            }
        }
    }
    
    return matches;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2f32
// Size: 0x61
function function_5ece41019f1c6583( ent, vols )
{
    foreach ( vol in vols )
    {
        if ( ent istouching( vol ) )
        {
            return vol;
        }
    }
    
    return undefined;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x2f9c
// Size: 0x28
function function_e4bbb844613590b5()
{
    guys = getaiarray( "axis" );
    
    if ( !isdefined( guys ) )
    {
        return [];
    }
    
    guys = array_removedead_or_dying( guys );
    return guys;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x2fcd
// Size: 0x180
function function_92fef86bd761fd5f( targetnames, var_ae76b192160c3341 )
{
    endon_notify = "clean_up_triggered:";
    
    foreach ( group in targetnames )
    {
        endon_notify += group + " ";
    }
    
    level endon( endon_notify );
    
    if ( !istrue( var_ae76b192160c3341 ) )
    {
        function_ae165af362de18a2();
    }
    
    guys = getaiarray( "axis" );
    
    if ( !isdefined( guys ) )
    {
        return undefined;
    }
    
    guys = array_removedead_or_dying( guys );
    
    if ( isdefined( level.ally ) )
    {
        guys = array_remove( guys, level.ally );
    }
    
    foreach ( guy in guys )
    {
        foreach ( group in targetnames )
        {
            if ( is_equal( guy.enemy_group, group ) )
            {
                guy.nodrop = 1;
                guy.noloot = 1;
                guy function_91da54e1e2dd71a0();
            }
        }
    }
    
    level notify( endon_notify );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x3155
// Size: 0x10c
function function_25a1f70006faef38( var_d63b148929b9717f, var_95a41debfff0e992 )
{
    guys = getaiarray( "axis" );
    
    if ( !isdefined( guys ) )
    {
        return undefined;
    }
    
    guys = array_removedead_or_dying( guys );
    
    if ( isdefined( level.ally ) )
    {
        guys = array_remove( guys, level.ally );
    }
    
    foreach ( guy in guys )
    {
        if ( isdefined( var_95a41debfff0e992 ) && guy.origin[ 2 ] > var_95a41debfff0e992 )
        {
            continue;
        }
        else if ( isdefined( var_d63b148929b9717f ) && distance( level.player.origin, guy.origin ) < var_d63b148929b9717f )
        {
            continue;
        }
        
        guy.nodrop = 1;
        guy.noloot = 1;
        guy function_91da54e1e2dd71a0();
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3269
// Size: 0x1b, Type: bool
function can_use_flashlight()
{
    return isdefined( self.noflashlight ) && self.noflashlight == 0;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x328d
// Size: 0x81
function function_7e92ee0fa837db0a( other )
{
    forwardvec = anglestoforward( flat_angle( other.angles ) );
    normalvec = vectornormalize( flat_origin( level.player.origin ) - other.origin );
    dot = vectordot( forwardvec, normalvec );
    
    if ( dot > 0 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x3316
// Size: 0xc6, Type: bool
function function_e7c30095a6cdc3ef( position )
{
    if ( !isdefined( level.player ) )
    {
        return false;
    }
    
    in_fov = within_fov( level.player geteye(), level.player getplayerangles(), position, cos( getdvarint( @"cg_fov" ) ) );
    
    if ( !in_fov )
    {
        return false;
    }
    
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
    castresult = physics_raycast( level.player geteye(), position, contents, undefined, 0, "physicsquery_closest", 0 );
    
    if ( isdefined( castresult ) && castresult.size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x33e5
// Size: 0x1a
function function_91da54e1e2dd71a0()
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    scripts\cp_mp\agents\agent_utils::despawnagent();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x3407
// Size: 0x89
function function_7f304aa00881ec8b( spawner_targetname )
{
    spawners = getstructarray( spawner_targetname, "targetname" );
    spawned_ai = [];
    
    foreach ( spawner in spawners )
    {
        guy = spawner spawn_ai();
        spawned_ai[ spawned_ai.size ] = guy;
    }
    
    return spawned_ai;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3499
// Size: 0xa4
function spawn_ai()
{
    ai_types = scripts\cp\spawning::get_aitypes_from_spawner();
    var_1bbe1e86bf2144d6 = random( ai_types );
    aitype = level.aitypes[ var_1bbe1e86bf2144d6 ].agent_type;
    var_44c998e27e126507 = scripts\mp\mp_agent::spawnnewagentaitype( aitype, self.origin, self.angles );
    
    if ( !var_44c998e27e126507 scripts\cp\spawning::is_specified_unittype( "civilian" ) )
    {
        var_44c998e27e126507 thread scripts\anim\squadmanager::addtosquad();
    }
    
    if ( isdefined( self.script_animname ) )
    {
        var_44c998e27e126507.animname = self.script_animname;
    }
    
    return var_44c998e27e126507;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3546
// Size: 0xbb
function function_3e3965174ac5ba05()
{
    var_13e1408230eebdc6 = [];
    var_522db6c2a400fb55 = level.br_pickups.scriptables;
    
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_pickups.scriptables ) )
    {
        return;
    }
    
    foreach ( item in var_522db6c2a400fb55 )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        if ( is_equal( item.type, "brloot_armor_plate" ) )
        {
            var_13e1408230eebdc6[ var_13e1408230eebdc6.size ] = item;
        }
    }
    
    return var_13e1408230eebdc6;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x360a
// Size: 0x5c
function function_587ee4c1e378644e( guys, var_447ab022a6d86603, wait_time )
{
    var_94de348177af1e87 = 0;
    
    while ( true )
    {
        wait 1;
        var_94de348177af1e87++;
        
        if ( var_94de348177af1e87 >= wait_time )
        {
            return;
        }
        
        guys = array_removedead_or_dying( guys );
        
        if ( guys.size <= var_447ab022a6d86603 )
        {
            /#
                function_95c757df3143199c( "<dev string:x32>" );
            #/
            
            return;
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x366e
// Size: 0x8
function function_3ac1f74e29c477d9()
{
    return function_1f067aa9b7648939();
}

/#

    // Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
    // Params 0
    // Checksum 0x0, Offset: 0x367f
    // Size: 0x5, Type: dev
    function function_bde20fbe4b714d29()
    {
        
    }

#/

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x368c
// Size: 0x2c
function function_10e0e4b151086982( flag1, flag2, flag3 )
{
    self endon( flag1 );
    self endon( flag2 );
    self endon( flag3 );
    level waittill( "INFINITY_BRO" );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x36c0
// Size: 0x65
function function_4467fca29549fcaa( var_a66a0bbe9ef0353, var_acba072b7e847a86, endon_string )
{
    level endon( endon_string );
    flag_wait( "broke_stealth_earlier" );
    wait 1;
    enemies = function_c890afce78d098bb( var_a66a0bbe9ef0353 );
    
    while ( true )
    {
        enemies = array_removedead_or_dying( enemies );
        
        if ( enemies.size == 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 3
// Checksum 0x0, Offset: 0x372d
// Size: 0x5a
function function_6928afc2794d18b4( var_acba072b7e847a86, var_d37c8cb09bff88c7, num_remaining )
{
    while ( !is_equal( var_d37c8cb09bff88c7.totalspawns, var_d37c8cb09bff88c7.ai_spawned.size ) )
    {
        waitframe();
    }
    
    function_ecc08f04b844e42( var_d37c8cb09bff88c7.ai_spawned, num_remaining );
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x378f
// Size: 0x23
function function_4e257994365fa73f( var_acba072b7e847a86, trig_name )
{
    function_d14fcd3a04720601( trig_name );
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x37ba
// Size: 0xd0
function function_845df931ada86cb1( var_acba072b7e847a86, trig_name )
{
    trigs = getentarray( trig_name, "targetname" );
    tracker = spawnstruct();
    tracker.is_player_touching = 0;
    
    foreach ( trig in trigs )
    {
        tracker thread function_a0231bddb9379d16( trig );
    }
    
    while ( true )
    {
        if ( istrue( tracker.is_player_touching ) )
        {
            flag_set( var_acba072b7e847a86 );
        }
        else
        {
            flag_clear( var_acba072b7e847a86 );
        }
        
        tracker.is_player_touching = 0;
        wait 0.2;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x3892
// Size: 0x73
function function_a0231bddb9379d16( trig )
{
    while ( true )
    {
        if ( !isdefined( level.player ) )
        {
            wait 1;
            continue;
        }
        
        if ( distance( level.player.origin, trig.origin ) < trig.struct.radius )
        {
            self.is_player_touching = 1;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x390d
// Size: 0xfc
function function_a07a9c680ab79d90( var_75327e74ace93a65, var_634b4b7aea5039c8 )
{
    tmporigin = ( var_634b4b7aea5039c8.origin[ 0 ], var_634b4b7aea5039c8.origin[ 1 ], var_75327e74ace93a65.origin[ 2 ] );
    directionvector = vectornormalize( var_75327e74ace93a65.origin - tmporigin );
    var_236e078486c73885 = vectordot( directionvector, anglestoforward( var_75327e74ace93a65 getplayerangles() ) );
    var_2388178486e384bf = vectordot( directionvector, anglestoright( var_75327e74ace93a65 getplayerangles() ) );
    
    if ( var_236e078486c73885 >= 0.6 )
    {
        return "behind";
    }
    else if ( var_236e078486c73885 <= -0.6 )
    {
        return "ahead";
    }
    else if ( var_2388178486e384bf >= 0.6 )
    {
        return "left";
    }
    else if ( var_2388178486e384bf <= -0.6 )
    {
        return "right";
    }
    
    iprintln( "get_position_relative hit undefined dir, FB=" + var_236e078486c73885 + ", LR=" + var_2388178486e384bf );
    return undefined;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3a12
// Size: 0x3ee
function function_30160e0f4ccb9aaf()
{
    var_25e0e219a5f51b66 = function_7a18da6e48b71c35( "skyhook_animnode" );
    
    if ( !isdefined( level.player_rig ) )
    {
        level.player_rig = spawn_anim_model( "player_rig" );
        level.player_rig hide();
    }
    
    if ( !isdefined( level.var_5e84860df880bbce ) )
    {
        level.var_5e84860df880bbce = spawn_anim_model( "3rd_person_player" );
        guy_head = spawn( "script_model", ( 0, 0, 0 ) );
        guy_head setmodel( "head_hero_price_lod" );
        guy_head linkto( level.var_5e84860df880bbce, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.var_5e84860df880bbce.headmodel = guy_head;
        level.var_5e84860df880bbce.weapon = level.var_5e84860df880bbce function_acc596689d609fdf();
        function_a88c360e19062b00( 0 );
    }
    
    if ( !isdefined( level.infil_ally ) )
    {
        level.infil_ally = spawn_anim_model( "infil_ally" );
        guy_head = spawn( "script_model", ( 0, 0, 0 ) );
        guy_head setmodel( "c_jup_head_hero_price_urban" );
        guy_head linkto( level.infil_ally, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infil_ally.headmodel = guy_head;
        level.infil_ally hide();
        level.var_2cd1144d4a670216 = spawn( "script_model", ( 0, 0, 0 ) );
        level.var_2cd1144d4a670216 setmodel( "offhand2h_tablet_static_v0_apt" );
        level.var_2cd1144d4a670216 linkto( level.infil_ally, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.var_2cd1144d4a670216 hide();
    }
    
    if ( !isdefined( level.infil_drone ) )
    {
        level.infil_drone = spawn_anim_model( "infil_drone" );
        level.infil_drone hide();
    }
    
    if ( !isdefined( level.exfil_plane ) )
    {
        level.exfil_plane = spawn_anim_model( "exfil_plane" );
        level.exfil_plane hide();
    }
    
    if ( !isdefined( level.hostage_cable ) )
    {
        level.hostage_cable = spawn_anim_model( "hostage_cable" );
        var_25e0e219a5f51b66 anim_first_frame_solo( level.hostage_cable, "skyhook_hvt" );
    }
    
    if ( !isdefined( level.player_cable ) )
    {
        level.player_cable = spawn_anim_model( "player_cable" );
        var_25e0e219a5f51b66 anim_first_frame_solo( level.player_cable, "skyhook_hvt" );
    }
    
    if ( !isdefined( level.hostage_carabiner ) )
    {
        level.hostage_carabiner = spawn_anim_model( "hostage_carabiner" );
        level.hostage_carabiner hide();
    }
    
    if ( !isdefined( level.player_carabiner ) )
    {
        level.player_carabiner = spawn_anim_model( "player_carabiner" );
        level.player_carabiner hide();
    }
    
    if ( !isdefined( level.spool ) )
    {
        level.spool = spawn_anim_model( "spool" );
        var_25e0e219a5f51b66 anim_first_frame_solo( level.spool, "skyhook_exfil" );
    }
    
    if ( !isdefined( level.var_133a64079b5e0c25 ) )
    {
        level.var_133a64079b5e0c25 = spawn_anim_model( "blimp_tether" );
        var_25e0e219a5f51b66 thread anim_single_solo( level.var_133a64079b5e0c25, "blimp_idle" );
    }
    
    if ( !isdefined( level.blimp ) )
    {
        level.blimp = spawn_anim_model( "blimp" );
        var_25e0e219a5f51b66 thread anim_single_solo( level.blimp, "blimp_idle" );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3e08
// Size: 0x144
function function_c65f472f4630bff7()
{
    triggers = getentarray( "flashlight_area", "targetname" );
    array_thread( triggers, &function_7c8ee987863c46fd );
    var_fac776a6ef59415f[ "flashlight_area" ] = &function_7c8ee987863c46fd;
    var_fac776a6ef59415f[ "ascender_hint" ] = &function_afbd2bd8ccb87427;
    triggers = getnoentvolumearray( "noent_volume_trigger_box", "classname" );
    triggers = array_combine( triggers, getentarray( "trigger_rotatable_radius", "classname" ) );
    
    foreach ( trigger in triggers )
    {
        if ( isdefined( trigger.struct ) )
        {
            data = trigger.struct;
        }
        else
        {
            data = trigger;
        }
        
        if ( isdefined( data.script_flag_set ) )
        {
            trigger.script_flag = data.script_flag_set;
            level thread namespace_16d9c1530a364ee9::trigger_flag_set( trigger );
        }
        
        if ( isdefined( data.targetname ) && isdefined( var_fac776a6ef59415f[ data.targetname ] ) )
        {
            trigger thread [[ var_fac776a6ef59415f[ data.targetname ] ]]();
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x3f54
// Size: 0xb2
function function_7c8ee987863c46fd()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", other );
        guys = getaiarray( "axis" );
        
        foreach ( guy in guys )
        {
            if ( !guy function_c3c2dc3918e8d50b() )
            {
                continue;
            }
            
            if ( !istrue( guy.var_8da673837c34f295 ) && guy istouching( self ) )
            {
                guy thread function_1073941f5d0fd4b7( self );
            }
        }
        
        wait 0.3;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x400e
// Size: 0x62
function function_1073941f5d0fd4b7( trigger )
{
    self endon( "death" );
    self.var_8da673837c34f295 = 1;
    wait randomfloatrange( 0.1, 2 );
    scripts\cp\nvg_ai::enable_flashlight( 1 );
    
    while ( self istouching( trigger ) && function_c3c2dc3918e8d50b() )
    {
        wait 0.5;
    }
    
    self.var_8da673837c34f295 = undefined;
    scripts\cp\nvg_ai::enable_flashlight( 0 );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4078
// Size: 0x2d, Type: bool
function function_c3c2dc3918e8d50b()
{
    return abs( self.origin[ 2 ] - level.player.origin[ 2 ] ) < 96;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x40ae
// Size: 0xd5
function function_afbd2bd8ccb87427()
{
    flag_wait( "start_mission_flow" );
    
    if ( !function_3ac1f74e29c477d9() )
    {
        level.player waittill( "ascender_device_pickedup" );
    }
    
    if ( !isdefined( level.var_e6d90ea1b7f78a7d ) )
    {
        level.var_e6d90ea1b7f78a7d = gettime() + 1500;
    }
    
    self.nexttime = 0;
    
    while ( true )
    {
        self waittill( "trigger", other );
        
        if ( isdefined( other ) && !isplayer( other ) )
        {
            continue;
        }
        
        if ( gettime() < level.var_e6d90ea1b7f78a7d )
        {
            continue;
        }
        
        if ( gettime() < self.nexttime )
        {
            continue;
        }
        
        level.var_e6d90ea1b7f78a7d = gettime() + 30000;
        self.nexttime = gettime() + 120000;
        thread function_fece794ef755bf46();
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x418b
// Size: 0x47d
function function_22c99e7fc51c0233()
{
    flag_wait( "start_mission_flow" );
    level.player.var_8d147b4b04ddd1b6 = spawnstruct();
    level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e = -2;
    level.player.var_8d147b4b04ddd1b6.var_5ed218cde7f05fbf = 0;
    level.player.var_8d147b4b04ddd1b6.nexttime = 0;
    level.player.var_8d147b4b04ddd1b6.building = "south";
    level.player.var_8d147b4b04ddd1b6.var_95a9af6eccc763cb = 0;
    level.player.var_8d147b4b04ddd1b6.var_a5810fb23e860a73 = gettime() + randomintrange( 30000, 60000 );
    var_3c1c17cfefac61ce = [];
    var_3c1c17cfefac61ce[ 0 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_movingtothebasement", "dx_cp_apar_move_gazz_iminthebasement" ], [ "dx_cp_apar_move_gazz_movingtothebasement_01", "dx_cp_apar_move_gazz_iminthebasement_01" ] );
    var_3c1c17cfefac61ce[ 5 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_movingtothe5thfloor", "dx_cp_apar_move_gazz_imonthe5thfloor" ], [ "dx_cp_apar_move_gazz_movingtothe5thfloor_01", "dx_cp_apar_move_gazz_imonthe5thfloor_01" ] );
    var_3c1c17cfefac61ce[ 6 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_movinguptothe6thfloo", "dx_cp_apar_move_gazz_imonlevelsixnow" ], [ "dx_cp_apar_move_gazz_movinguptothe6thfloo_01", "dx_cp_apar_move_gazz_imonlevelsixnow_01" ] );
    var_3c1c17cfefac61ce[ 7 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_goinguptothe7thfloor", "dx_cp_apar_move_gazz_onthe7thfloor" ], [ "dx_cp_apar_move_gazz_goinguptothe7thfloor_01", "dx_cp_apar_move_gazz_onthe7thfloor_01" ] );
    var_3c1c17cfefac61ce[ 8 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_pressingupto8now", "dx_cp_apar_move_gazz_onleveleight" ], [ "dx_cp_apar_move_gazz_pressingupto8now_01", "dx_cp_apar_move_gazz_onleveleight_01" ] );
    var_3c1c17cfefac61ce[ 9 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_ascendingtothe9thflo", "dx_cp_apar_move_gazz_onthe9thfloor" ], [ "dx_cp_apar_move_gazz_ascendingtothe9thflo_01", "dx_cp_apar_move_gazz_onthe9thfloor_01" ] );
    var_3c1c17cfefac61ce[ 11 ] = function_5133b8b4bd2a8e04( [ "dx_cp_apar_move_gazz_movingtothe11thfloor", "dx_cp_apar_move_gazz_imoneleven" ], [ "dx_cp_apar_move_gazz_movingtothe11thfloor_01", "dx_cp_apar_move_gazz_imoneleven_01" ] );
    level.player.var_8d147b4b04ddd1b6.var_3c1c17cfefac61ce = var_3c1c17cfefac61ce;
    responses = [];
    responses[ responses.size ] = "dx_cp_apar_move_pric_copy";
    responses[ responses.size ] = "dx_cp_apar_move_pric_copythat";
    responses[ responses.size ] = "dx_cp_apar_move_pric_rog";
    responses[ responses.size ] = "dx_cp_apar_move_pric_copy_01";
    responses[ responses.size ] = "dx_cp_apar_move_pric_copythat_01";
    responses[ responses.size ] = "dx_cp_apar_move_pric_rog_01";
    responses[ responses.size ] = "dx_cp_apar_move_pric_check";
    responses[ responses.size ] = "dx_cp_apar_move_pric_affirm";
    responses[ responses.size ] = "dx_cp_apar_move_pric_affirmative";
    responses[ responses.size ] = "dx_cp_apar_move_pric_solidcopy";
    responses[ responses.size ] = "dx_cp_apar_move_pric_goodcopy";
    responses[ responses.size ] = "dx_cp_apar_move_pric_gotit";
    deck = create_deck( responses, 1, 1 );
    level.player.var_8d147b4b04ddd1b6.var_c11d978f66f7b9d8 = deck;
    var_53760d61f9941846 = [];
    var_53760d61f9941846[ 0 ] = [ "dx_cp_apar_move_pric_stepitupyougotthewho", "dx_cp_apar_move_pric_stepitupyougotthewho_01" ];
    var_53760d61f9941846[ 5 ] = [ "dx_cp_apar_move_pric_stillhavealotofkonni", "dx_cp_apar_move_pric_stillhavealotofkonni_01" ];
    var_53760d61f9941846[ 6 ] = [ "dx_cp_apar_move_pric_yourehalfwaytheregaz", "dx_cp_apar_move_pric_yourehalfwaytheregaz_01" ];
    var_53760d61f9941846[ 7 ] = [ "dx_cp_apar_move_pric_keeppushing", "dx_cp_apar_move_pric_keeppushing_01" ];
    var_53760d61f9941846[ 8 ] = [ "dx_cp_apar_move_pric_fewmoretogoletsgetth", "dx_cp_apar_move_pric_fewmoretogoletsgetth_01" ];
    var_53760d61f9941846[ 9 ] = [ "dx_cp_apar_move_pric_nearlytheregaz", "dx_cp_apar_move_pric_nearlytheregaz_01" ];
    level.player.var_8d147b4b04ddd1b6.var_93fce89f7341c284 = var_53760d61f9941846;
    level.player.var_8d147b4b04ddd1b6.var_a90a87e52402c318 = [];
    
    foreach ( _ in var_53760d61f9941846 )
    {
        level.player.var_8d147b4b04ddd1b6.var_a90a87e52402c318[ i ] = 0;
    }
    
    level.player thread function_c04bd56c9e14e83b();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x4610
// Size: 0x3b
function function_5133b8b4bd2a8e04( aliases, var_f639fb459a0c4dd3 )
{
    array = [];
    array[ 0 ] = create_deck( aliases, 0, 0 );
    array[ 1 ] = create_deck( var_f639fb459a0c4dd3, 0, 0 );
    return array;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4654
// Size: 0x39f
function function_c04bd56c9e14e83b()
{
    [ var_c047165c98ce955f ] = getnoentvolumearray( "courtyard_tracking", "targetname" );
    var_26d4bc420f7164b8 = getnoentvolumearray( "northbuilding_tracking", "targetname" );
    var_24f6e3ab7856fd82 = getnoentvolumearray( "southbuilding_tracking", "targetname" );
    temp = getstructarray( "floor_tracking", "targetname" );
    var_e8e0a4c291958d95 = [];
    
    foreach ( struct in temp )
    {
        var_e8e0a4c291958d95[ struct.script_index ] = struct;
    }
    
    var_e848dcc2ba6bf407 = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !level.player isonground() )
        {
            continue;
        }
        
        if ( level.player istouching( var_c047165c98ce955f ) )
        {
            if ( level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e != 1 )
            {
                function_a3fb599570c96974( 1 );
            }
            
            level.player.var_8d147b4b04ddd1b6.building = undefined;
            continue;
        }
        
        building = undefined;
        
        foreach ( trigger in var_26d4bc420f7164b8 )
        {
            if ( self istouching( trigger ) )
            {
                building = "north";
                break;
            }
        }
        
        if ( !isdefined( building ) )
        {
            foreach ( trigger in var_24f6e3ab7856fd82 )
            {
                if ( self istouching( trigger ) )
                {
                    building = "south";
                    break;
                }
            }
        }
        
        level.player.var_8d147b4b04ddd1b6.building = building;
        
        if ( !isdefined( building ) )
        {
            continue;
        }
        
        var_e29da04f02883964 = undefined;
        
        foreach ( struct in var_e8e0a4c291958d95 )
        {
            delta = level.player.origin[ 2 ] - struct.origin[ 2 ];
            
            if ( delta < 0 )
            {
                continue;
            }
            
            if ( delta > struct.height )
            {
                continue;
            }
            
            var_e29da04f02883964 = struct;
        }
        
        if ( !isdefined( var_e29da04f02883964 ) )
        {
            continue;
        }
        
        if ( !var_e848dcc2ba6bf407 )
        {
            if ( var_e29da04f02883964.script_index >= 6 )
            {
                var_e848dcc2ba6bf407 = 1;
            }
        }
        
        if ( level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e != var_e29da04f02883964.script_index )
        {
            function_a3fb599570c96974( var_e29da04f02883964.script_index );
            
            if ( gettime() < level.player.var_8d147b4b04ddd1b6.nexttime )
            {
                continue;
            }
            
            if ( var_e848dcc2ba6bf407 )
            {
                level.player thread function_10e690781771338e();
            }
            
            level.player.var_8d147b4b04ddd1b6.nexttime = gettime() + 5000;
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x49fb
// Size: 0x99
function function_a3fb599570c96974( floornum )
{
    level.player notify( "update_player_floor" );
    level.player.var_8d147b4b04ddd1b6.var_5ed218cde7f05fbf = level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e;
    level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e = floornum;
    function_f91fa393e481c957( level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x4a9c
// Size: 0x34
function function_17b7868bdc4351d8( time )
{
    level.player.var_8d147b4b04ddd1b6.delayedtime = gettime() + time * 1000;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4ad8
// Size: 0x285
function function_10e690781771338e()
{
    self endon( "callout_say" );
    self endon( "death" );
    
    if ( isdefined( level.player.var_8d147b4b04ddd1b6.delaytime ) )
    {
        if ( gettime() < level.player.var_8d147b4b04ddd1b6.delayedtime )
        {
            return;
        }
        
        level.player.var_8d147b4b04ddd1b6.delayedtime = undefined;
    }
    
    floornum = function_b3caa25301d7148b();
    
    if ( !isdefined( self.var_8d147b4b04ddd1b6.var_3c1c17cfefac61ce[ floornum ] ) )
    {
        return;
    }
    
    combatstate = 0;
    
    if ( function_1e4aaaddfd5236ca() )
    {
        combatstate = 1;
    }
    
    function_a6ee2346a2b961bf( 5 );
    downward = level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e < level.player.var_8d147b4b04ddd1b6.var_5ed218cde7f05fbf;
    
    if ( downward )
    {
        if ( gettime() > self.var_8d147b4b04ddd1b6.var_a5810fb23e860a73 && cointoss() )
        {
            self.var_8d147b4b04ddd1b6.var_a5810fb23e860a73 = gettime() + randomintrange( 30000, 50000 );
            aliases = [ "dx_cp_apar_upr1_pric_stepitupsergeanttarg", "dx_cp_apar_upr1_pric_keepitmovinggazwesti" ];
            level say( random( aliases ) );
            return;
        }
        else
        {
            alias = self.var_8d147b4b04ddd1b6.var_3c1c17cfefac61ce[ floornum ][ combatstate ].items[ 1 ];
        }
    }
    else
    {
        alias = self.var_8d147b4b04ddd1b6.var_3c1c17cfefac61ce[ floornum ][ combatstate ] deck_draw();
    }
    
    say( alias );
    wait 0.4;
    var_53c74bedb8e2b26 = 0;
    
    if ( gettime() > self.var_8d147b4b04ddd1b6.var_95a9af6eccc763cb )
    {
        if ( function_a2d27d8d3f2f0fd4( floornum ) )
        {
            var_53c74bedb8e2b26 = 1;
            aliases = self.var_8d147b4b04ddd1b6.var_93fce89f7341c284[ floornum ];
            self.var_8d147b4b04ddd1b6.var_a90a87e52402c318[ floornum ] = gettime() + 30000;
            say( aliases[ combatstate ] );
        }
    }
    
    if ( !var_53c74bedb8e2b26 )
    {
        alias = self.var_8d147b4b04ddd1b6.var_c11d978f66f7b9d8 deck_draw();
        level say( alias );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x4d65
// Size: 0x48, Type: bool
function function_a2d27d8d3f2f0fd4( floornum )
{
    if ( !isdefined( self.var_8d147b4b04ddd1b6.var_93fce89f7341c284[ floornum ] ) )
    {
        return false;
    }
    
    if ( gettime() < self.var_8d147b4b04ddd1b6.var_a90a87e52402c318[ floornum ] )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4db6
// Size: 0xe, Type: bool
function function_1e4aaaddfd5236ca()
{
    if ( stealthgetanyaiincombat() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4dcd
// Size: 0x1f
function function_b3caa25301d7148b()
{
    return level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4df5
// Size: 0x1f
function function_3c2f10ae0ccbe003()
{
    return level.player.var_8d147b4b04ddd1b6.building;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4e1d
// Size: 0x9d
function function_a86d1d13a41da5b4()
{
    flag_wait( "start_mission_flow" );
    level.var_103c35b2bd860212 = tolower( getdvar( @"ui_mapname" ) );
    floors = [];
    floors[ 0 ] = 0;
    floors[ 1 ] = 1;
    floors[ 5 ] = 2;
    floors[ 6 ] = 3;
    floors[ 7 ] = 3;
    floors[ 8 ] = 4;
    floors[ 9 ] = 5;
    floors[ 10 ] = 6;
    floors[ 11 ] = 6;
    floors[ 12 ] = 7;
    level.var_52d0c9700794f182 = floors;
    function_f91fa393e481c957( 0 );
    level.player thread function_34060730f44eb4f2();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x4ec2
// Size: 0xdb
function function_34060730f44eb4f2()
{
    self setclientomnvar( "ui_minimap_min_floor", 0 );
    self setclientomnvar( "ui_minimap_max_floor", 12 );
    self.var_109a3bfd035f27be = 0;
    
    for ( ;; )
    {
        self waittill( "luinotifyserver", channel, value );
        
        if ( channel == "minimap_floor_switch" )
        {
            switch ( value )
            {
                case 1:
                    minimap_floor_switch( 1 );
                    break;
                case 4294967295:
                    minimap_floor_switch( -1 );
                    break;
                case 0:
                    minimap_floor_switch( self.var_109a3bfd035f27be );
                    break;
            }
            
            continue;
        }
        
        if ( channel == "scoreboard_close" )
        {
            function_f91fa393e481c957( level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e );
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x4fa5
// Size: 0x76
function minimap_floor_switch( val )
{
    desired = self.var_109a3bfd035f27be + val;
    
    if ( val > 0 )
    {
        while ( !isdefined( level.var_52d0c9700794f182[ desired ] ) )
        {
            desired++;
            
            if ( desired > 12 )
            {
                desired = 12;
                break;
            }
        }
    }
    else
    {
        while ( !isdefined( level.var_52d0c9700794f182[ desired ] ) )
        {
            desired--;
            
            if ( desired < 0 )
            {
                desired = 0;
                break;
            }
        }
    }
    
    function_f91fa393e481c957( desired );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x5023
// Size: 0xac
function function_f91fa393e481c957( floornum )
{
    if ( floornum < 0 )
    {
        floornum = 0;
    }
    
    if ( !isdefined( level.var_52d0c9700794f182[ floornum ] ) )
    {
        return;
    }
    
    level.player.var_109a3bfd035f27be = floornum;
    var_c3958e917e053f8e = level.var_52d0c9700794f182[ floornum ];
    level.player setclientomnvar( "ui_minimap_floor", floornum );
    map_name = tolower( getdvar( @"ui_mapname" ) );
    minimap_image = "compass_map_" + level.var_103c35b2bd860212 + "_floor_" + var_c3958e917e053f8e;
    scripts\cp\cp_compass::setupminimap( minimap_image );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x50d7
// Size: 0x7e
function function_8fee9387d2427d9f()
{
    icon_type = self.type;
    var_dee665d6bbb2eb8b = self.origin;
    notification = waittill_any_return_6( "death", "disconnect", "headicon_deleted", "deleted", "discovery_icon_moved", "discovery_icon_removed" );
    
    if ( isdefined( icon_type ) && icon_type == "brloot_armor_plate" )
    {
        iprintlnbold( "" + icon_type + ": " + notification );
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x515d
// Size: 0x1ce
function function_aba7e24cef7c6d5()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( "object_removed" );
    level thread tacmap_floor_monitor();
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.var_3d33ce746b270d75.headicon, level.players[ 0 ] );
    
    if ( !isdefined( self.var_3d33ce746b270d75.var_258010cf3334d9e4 ) )
    {
        self.var_3d33ce746b270d75.var_258010cf3334d9e4 = function_7817080b1c3de03d();
    }
    
    if ( !flag( "start_mission_flow" ) )
    {
        flag_wait( "start_mission_flow" );
        wait 0.1;
    }
    
    if ( !function_83308b8909515372( level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e ) )
    {
        hideheadiconfromplayersinmask( self.var_3d33ce746b270d75.headicon );
    }
    
    while ( true )
    {
        level.player waittill_any_4( "update_player_floor", "tacmap_opened", "tacmap_closed", "minimap_floor_switch" );
        iconinfo = setheadicon_getexistingiconinfo( self.var_3d33ce746b270d75.headicon );
        
        if ( !isdefined( iconinfo ) )
        {
            continue;
        }
        
        current_floor = level.player.var_8d147b4b04ddd1b6.var_dbdcfb2d013fec6e;
        
        if ( level.player istacmapactive() )
        {
            waitframe();
            current_floor = level.player getclientomnvar( "ui_minimap_floor" );
        }
        
        if ( isdefined( self.var_3d33ce746b270d75.headicon ) )
        {
            if ( function_83308b8909515372( current_floor ) )
            {
                showheadicontoplayersinmask( self.var_3d33ce746b270d75.headicon );
            }
            else
            {
                hideheadiconfromplayersinmask( self.var_3d33ce746b270d75.headicon );
            }
            
            continue;
        }
        
        return;
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x5333
// Size: 0x40, Type: bool
function function_83308b8909515372( floor_num )
{
    should_show = 0;
    
    if ( self.var_3d33ce746b270d75.var_258010cf3334d9e4 == floor_num )
    {
        return true;
    }
    
    if ( function_a6727ec1ffa207fe( floor_num ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x537c
// Size: 0x6f, Type: bool
function function_a6727ec1ffa207fe( floor_num )
{
    if ( isdefined( self.var_3d33ce746b270d75.var_66a026699213b4b3 ) && isdefined( self.var_3d33ce746b270d75.var_f9d2b79c091d9679 ) )
    {
        if ( floor_num >= self.var_3d33ce746b270d75.var_66a026699213b4b3 && floor_num <= self.var_3d33ce746b270d75.var_f9d2b79c091d9679 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x53f4
// Size: 0x3f
function function_92c08eb8cf927231( icon_index )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "deleted" );
    waittill_any_2( "discovery_icon_moved", "discovery_icon_removed" );
    waitframe();
    
    if ( isdefined( self ) )
    {
        thread function_aba7e24cef7c6d5();
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x543b
// Size: 0x259
function function_7817080b1c3de03d()
{
    temp = getstructarray( "floor_tracking", "targetname" );
    var_e8e0a4c291958d95 = [];
    
    foreach ( struct in temp )
    {
        var_e8e0a4c291958d95[ struct.script_index ] = struct;
    }
    
    var_e29da04f02883964 = undefined;
    
    for ( i = 0; i < var_e8e0a4c291958d95.size ; i++ )
    {
        delta = self.origin[ 2 ] - var_e8e0a4c291958d95[ i ].origin[ 2 ];
        
        if ( delta > 0 )
        {
            var_e29da04f02883964 = var_e8e0a4c291958d95[ i ];
            continue;
        }
        
        break;
    }
    
    if ( isdefined( self.var_3d33ce746b270d75.var_c771dc8336087985 ) && isdefined( self.var_3d33ce746b270d75.var_d080815319e36ef7 ) )
    {
        if ( self.origin == ( 1759.36, 1807.37, 2111.25 ) )
        {
            return 12;
        }
        
        var_7cb28267a8a8ae25 = 12;
        var_d21d91ab7b353fbf = 0;
        var_575742034a57ca0e = 50;
        
        for ( i = 0; i < var_e8e0a4c291958d95.size ; i++ )
        {
            var_696740dd6bee70f9 = self.var_3d33ce746b270d75.var_c771dc8336087985[ 2 ] - var_e8e0a4c291958d95[ i ].origin[ 2 ] - var_575742034a57ca0e;
            
            if ( var_696740dd6bee70f9 > 0 )
            {
                var_7cb28267a8a8ae25 = var_e8e0a4c291958d95[ i ].script_index;
                continue;
            }
            
            break;
        }
        
        for ( i = 0; i < var_e8e0a4c291958d95.size ; i++ )
        {
            var_8e78aa3b48c0ee75 = self.var_3d33ce746b270d75.var_d080815319e36ef7[ 2 ] - var_e8e0a4c291958d95[ i ].origin[ 2 ];
            
            if ( var_8e78aa3b48c0ee75 > 0 )
            {
                var_d21d91ab7b353fbf = var_e8e0a4c291958d95[ i ].script_index;
                continue;
            }
            
            break;
        }
        
        self.var_3d33ce746b270d75.var_f9d2b79c091d9679 = var_7cb28267a8a8ae25;
        self.var_3d33ce746b270d75.var_66a026699213b4b3 = var_d21d91ab7b353fbf;
    }
    
    if ( !isdefined( var_e29da04f02883964 ) )
    {
        return 0;
    }
    
    return var_e29da04f02883964.script_index;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x569d
// Size: 0x89
function tacmap_floor_monitor()
{
    level notify( "tacmap_floor_monitor" );
    level endon( "tacmap_floor_monitor" );
    
    if ( isdefined( level.players[ 0 ] ) )
    {
        level.players[ 0 ] endon( "death" );
        level.players[ 0 ] endon( "disconnect" );
    }
    
    for ( ;; )
    {
        level.players[ 0 ] waittill( "luinotifyserver", channel, value );
        
        if ( channel == "minimap_floor_switch" )
        {
            level.players[ 0 ] notify( "minimap_floor_switch" );
        }
    }
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x572e
// Size: 0x49
function function_7e7d0b7221a5ab23( groupname, guy )
{
    function_4c9c11f7cd27ff64( groupname );
    level._ai_group[ groupname ].ai[ level._ai_group[ groupname ].ai.size ] = guy;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x577f
// Size: 0x20
function function_d330ef725ee0137c( groupname )
{
    return level._ai_group[ groupname ].ai;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x57a8
// Size: 0x21
function function_6f029baefb2143cf( groupname )
{
    return level._ai_group[ groupname ].ai.size;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x57d2
// Size: 0x5a
function function_4c9c11f7cd27ff64( groupname )
{
    if ( !isdefined( level._ai_group ) )
    {
        level._ai_group = [];
    }
    
    if ( isdefined( level._ai_group[ groupname ] ) )
    {
        return;
    }
    
    level._ai_group[ groupname ] = spawnstruct();
    level._ai_group[ groupname ].ai = [];
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x5834
// Size: 0x124
function function_f7fca5ff69effe3a( targetent )
{
    from = flat_origin( level.player.origin );
    to = flat_origin( targetent.origin );
    dir = vectornormalize( to - from );
    player_forward = anglestoforward( level.player.angles );
    player_right = anglestoright( level.player.angles );
    dot_forward = vectordot( player_forward, dir );
    dot_right = vectordot( player_right, dir );
    var_7b7c861ff6ba18f3 = undefined;
    
    if ( dot_right > 0.707 )
    {
        var_7b7c861ff6ba18f3 = "right";
    }
    else if ( dot_right < -0.707 )
    {
        var_7b7c861ff6ba18f3 = "left";
    }
    else if ( dot_forward > 0.707 )
    {
        var_7b7c861ff6ba18f3 = "ahead";
    }
    else if ( dot_forward < -0.707 )
    {
        var_7b7c861ff6ba18f3 = "behind";
    }
    
    return var_7b7c861ff6ba18f3;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 2
// Checksum 0x0, Offset: 0x5961
// Size: 0xe3
function function_ea1bb8d5abcfc328( ent_or_org, duration )
{
    marker = newhudelem();
    marker setshader( "icon_waypoint_enemy_marker", 2, 2 );
    marker.alpha = 1;
    marker setwaypoint( 1, 1, 1 );
    
    if ( isent( ent_or_org ) )
    {
        tag_pos = ent_or_org gettagorigin( "j_head" );
        dist = distance( ent_or_org.origin, tag_pos );
        offset = ( 0, 0, dist + 5 );
        marker linkwaypointtotargetwithoffset( ent_or_org, offset );
    }
    else
    {
        marker.x = ent_or_org[ 0 ];
        marker.y = ent_or_org[ 1 ];
        marker.z = ent_or_org[ 2 ];
    }
    
    marker thread function_404b4886b8126598( duration );
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 1
// Checksum 0x0, Offset: 0x5a4c
// Size: 0x14
function function_404b4886b8126598( timeout )
{
    wait timeout;
    self destroy();
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x5a68
// Size: 0x9b
function function_2cefd0205583ac50()
{
    guys = getaiarray( "axis" );
    hunters = [];
    
    foreach ( guy in guys )
    {
        if ( guy doinglongdeath() )
        {
            continue;
        }
        
        if ( !isdefined( guy.fnisinstealthhunt ) )
        {
            continue;
        }
        
        if ( guy [[ guy.fnisinstealthhunt ]]() )
        {
            hunters[ hunters.size ] = guy;
        }
    }
    
    return hunters;
}

// Namespace namespace_41966f109cd424ff / namespace_897c361e01268820
// Params 0
// Checksum 0x0, Offset: 0x5b0c
// Size: 0x86
function function_18b3aed9ff371aac()
{
    [ trigger ] = getnoentvolumearray( "mid_2_open_area", "targetname" );
    event = "silenced_shot";
    
    while ( true )
    {
        trigger waittill( "trigger" );
        prev = geteventheight( event );
        seteventheight( event, 0 );
        
        while ( level.player istouching( trigger ) )
        {
            wait 0.1;
        }
        
        seteventheight( event, prev );
    }
}

